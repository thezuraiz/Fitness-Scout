import 'package:fitness_scout/data/repositories/user/user_repository.dart';
import 'package:fitness_scout/features/gym_pool/controller/gym_pool_controller.dart';
import 'package:fitness_scout/features/personalization/controller/user_controller.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../model/gym_model.dart';

class GymBottomSheet extends StatelessWidget {
  const GymBottomSheet(
      {super.key,
      required this.gyms,
      required this.userLocation,
      required this.onGymSelected});

  final List<GymOwnerModel> gyms;
  final Position userLocation;
  final Function(double latitude, double longitude) onGymSelected;

  @override
  Widget build(BuildContext context) {
    ZLogger.info('GYMS in Bottom Sheet: ${gyms.length}');
    final controller = Get.put(GymBottomSheetController());
    return Column(
      children: [
        SizedBox(
          height: 190,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: ZSizes.defaultSpace),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Distance:',
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
                        value: controller.selectedDistance,
                        onChanged: (int? newValue) {
                          controller.selectedDistance = newValue!;
                          controller.filterGymsByDistanceAndPackageType(
                              controller.selectedDistance);
                          Get.back();
                        },
                        items: controller.distanceOptions
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
                controller.filteredGyms.value.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Iconsax.info_circle,
                            size: 80,
                          ),
                          const SizedBox(
                            height: ZSizes.spaceBtwItems,
                          ),
                          Text(
                            'No Nearby Location!',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            'Total Number of active GYMS: ${gyms.length}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      )
                    : Obx(
                        () => Expanded(
                          child: ListView.builder(
                              itemCount: controller.filteredGyms.length,
                              itemBuilder: (context, index) {
                                final list = controller.filteredGyms[index];
                                ZLogger.info('List ->');
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: ZSizes.sm),
                                  color: ZHelperFunction.isDarkMode(context)
                                      ? ZColor.dark
                                      : ZColor.lightContainer,
                                  child: ListTile(
                                    onTap: () {
                                      onGymSelected(
                                        list.location!.latitude,
                                        list.location!.longitude,
                                      );
                                    },
                                    title: Text(list.gymName.toString()),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(list.address.toString()),
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
                                                      text: list.ratings
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge),
                                                  TextSpan(
                                                      text:
                                                          ' (${list.visitors!.length})')
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GymBottomSheetController extends GetxController {
  final List<int> distanceOptions = [1, 2, 3, 4, 5, 100];
  int selectedDistance = 1;
  RxList filteredGyms = [].obs; // Reactive list
  RxList<GymOwnerModel> gyms = GymPoolController.instance.gyms;
  late Position userLocation;
  late Function(double latitude, double longitude) onGymSelected;

  @override
  void onReady() {
    super.onReady();
    ZLogger.info('Bottom Sheet Opened');
    _getUserLocation();
    GymPoolController.instance.loadGYMS();
  }

  // Fetch user location
  Future<void> _getUserLocation() async {
    try {
      userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      filterGymsByDistanceAndPackageType(selectedDistance);
    } catch (e) {
      ZLogger.error("Error getting user location: $e");
    }
  }

  /// Filter gyms based on distance and user's package type
  void filterGymsByDistanceAndPackageType(int distanceKM) async {
    final String userPackage =
        UserController.instance.user.value.currentPackage;

    ZLogger.info(
        'Filtering gyms within $distanceKM km for package: $userPackage');
    ZLogger.info(
        'Gyms: ${gyms.value.map((e) => e.name + ' ' + e.gymType.name)}');

    // Filter gyms based on distance and package type
    filteredGyms.value = await gyms.value.where((gym) {
      if (gym.isApproved != 'Approved') return false;

      final double distanceInMeters = Geolocator.distanceBetween(
        userLocation.latitude,
        userLocation.longitude,
        gym.location!.latitude,
        gym.location!.longitude,
      );
      final userPackage =
          UserController.instance.user.value.currentPackage.split(' ')[0];

      ZLogger.info('gym.gymType.name: ${gym.gymType.name}');
      ZLogger.info('userPackage: ${userPackage}');

      // Check if the gym type matches the user's package
      if (gym.gymType.name != userPackage) return false;

      return distanceInMeters <= distanceKM * 1000;
    }).toList();

    ZLogger.info('filteredGyms: ${filteredGyms}');
  }

// void filterGymsByDistanceAndPackageType(int distanceKM) {
//   final userPackage = UserController.instance.user.value.currentPackage;
//   ZLogger.info('Calculating Nearby GYMs within $distanceKM');
//   ZLogger.info('User Package: $userPackage');
//   ZLogger.info('Gyms length: ${gyms.value.length}');
//
//   filteredGyms.value = gyms.value.map((e) {
//     ZLogger.info('Name: ${e.name}, Approved: ${e.isApproved}');
//     return {
//       'name': e.name,
//       'ratings': e.ratings,
//       'address': e.address,
//       'visitors': e.visitors?.length ?? 0,
//       'latitude': e.location!.latitude,
//       'longitude': e.location!.longitude
//     };
//   }).toList();
//
//   filteredGyms.value.map((e) {
//     return distanceInMeters <= distanceKM * 1000 &&
//         e.gymType.name == userPackage;
//   });
//
//   ZLogger.info('data: ${filteredGyms}');
// }
}
