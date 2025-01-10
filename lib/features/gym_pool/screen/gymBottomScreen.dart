import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../model/gym_model.dart';

class GymBottomSheet extends StatefulWidget {
  final List<GymOwnerModel> gyms;
  final Position userLocation;
  final Function(double latitude, double longitude) onGymSelected;

  const GymBottomSheet({
    Key? key,
    required this.gyms,
    required this.userLocation,
    required this.onGymSelected,
  }) : super(key: key);

  @override
  _GymBottomSheetState createState() => _GymBottomSheetState();
}

class _GymBottomSheetState extends State<GymBottomSheet> {
  final List<int> distanceOptions = [1, 2, 3, 4, 5];
  int selectedDistance = 1;
  late List<GymOwnerModel> filteredGyms;

  @override
  void initState() {
    super.initState();
    _filterGymsByDistance(selectedDistance);
  }

  void _filterGymsByDistance(int distanceKM) {
    setState(() {
      filteredGyms = widget.gyms.where((gym) {
        if (gym.location == null) return false;
        double distanceInMeters = Geolocator.distanceBetween(
          widget.userLocation.latitude,
          widget.userLocation.longitude,
          gym.location!.latitude,
          gym.location!.longitude,
        );
        return distanceInMeters <= distanceKM * (selectedDistance * 1000);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return filteredGyms.isEmpty
        ? SizedBox(
            height: 170,
            child: Center(
              child: Column(
                children: [
                  const Icon(
                    Iconsax.info_circle,
                    size: 80,
                  ),
                  const SizedBox(
                    height: ZSizes.spaceBtwItems,
                  ),
                  Text(
                    'No Nearby Location',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height / 2.7,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: ZSizes.defaultSpace),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Distance: ',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      DropdownButton<int>(
                        elevation: 10,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        icon: const Icon(
                          Iconsax.direct_left,
                          size: 18,
                        ),
                        value: selectedDistance,
                        onChanged: (int? newValue) {
                          setState(() {
                            selectedDistance = newValue!;
                            _filterGymsByDistance(selectedDistance);
                          });
                        },
                        items: distanceOptions
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text('$value KM'),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (_, __) => const SizedBox(
                      height: ZSizes.spaceBtwItems,
                    ),
                    itemCount: filteredGyms.length,
                    itemBuilder: (context, index) {
                      final gym = filteredGyms[index];
                      return Card(
                        margin:
                            const EdgeInsets.symmetric(horizontal: ZSizes.sm),
                        color: ZHelperFunction.isDarkMode(context)
                            ? ZColor.dark
                            : ZColor.lightContainer,
                        child: ListTile(
                          onTap: () {
                            widget.onGymSelected(
                              gym.location!.latitude,
                              gym.location!.longitude,
                            );
                          },
                          title: Text(gym.gymName.toString()),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(gym.address.toString()),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Iconsax.star5,
                                    color: Colors.amber,
                                    size: 24,
                                  ),
                                  const SizedBox(
                                    width: ZSizes.spaceBtwItems / 2,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text: gym.ratings.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge),
                                        TextSpan(
                                            text: ' (${gym.visitors!.length})')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
  }
}
