import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:fitness_scout/data/repositories/gym_pool/gym_pool_repository.dart';
import 'package:fitness_scout/features/gym_pool/controller/gym_scanner_controller.dart';
import 'package:fitness_scout/features/gym_pool/screen/gymProfilePage.dart';
import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:ui' as ui;
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../model/gym_model.dart';
import '../screen/gymBottomScreen.dart';

class GymPoolController extends GetxController {
  static GymPoolController get instance => Get.find();

  @override
  void onInit() async {
    super.onInit();
    await loadGYMS();
    await fetchCurrentLocation();
  }

  static RxBool isAllowedToCheckIn = true.obs;
  BitmapDescriptor? customMarkerIcon;
  RxBool isDarkMode = ZHelperFunction.isDarkMode(Get.context!).obs;
  Rx<LatLng> userLocation = const LatLng(31.5204, 74.3587).obs;
  Set<Marker> markers = <Marker>{}.obs;
  RxList<GymOwnerModel> gyms = <GymOwnerModel>[].obs;
  final gymRepository = Get.put(GymPoolRepository());
  GoogleMapController? googleMapController;

  Rx<CustomInfoWindowController> customInfoWindowController =
      CustomInfoWindowController().obs;

  final CameraPosition initialPosition = const CameraPosition(
    target: LatLng(31.5204, 74.3587), // Default location
    zoom: 14.4746,
  );

  void _addSurroundingMarkers() {
    ZLogger.info('Adding ${gyms.length} gym markers.');
    gyms.forEach((gym) async {
      if (gym.location != null) {
        final Uint8List iconMarker = await _loadCustomMarkerIcon();

        markers.add(
          Marker(
              markerId: MarkerId(gym.id),
              icon: BitmapDescriptor.fromBytes(iconMarker) ??
                  BitmapDescriptor.defaultMarker,
              // infoWindow: InfoWindow(
              //   title: gym.gymName,
              //   snippet: gym.description,
              // ),
              position: LatLng(gym.location!.latitude, gym.location!.longitude),
              onTap: () {
                Get.to(GymDetailScreen(gym: gym));
                Get.reload();
              }),
        );
      }
    });
    ZLogger.info('Total markers: ${markers.length}');
  }

  // ZLogger.warning('Maps: ${markers}');

  Future<String> loadMapStyle(BuildContext context) async {
    String fileName = isDarkMode.value
        ? 'assets/map_styles/dark_map_style.json'
        : 'assets/map_styles/light_map_style.json';

    try {
      String mapStyle = await rootBundle.loadString(fileName);
      // ZLogger.info('Loaded Map Style: $mapStyle'); // Debugging print
      // ZLogger.info('Current Theme: ${isDarkMode.value ? "Dark" : "Light"}');
      return mapStyle;
    } catch (e) {
      ZLogger.info('Error loading map style: $e');
      return 'Error loading map style: $e'; // Return empty string if there's an error
    }
  }

  Future<void> loadGYMS() async {
    gyms.value = await gymRepository.fetchGYMS();
    _addSurroundingMarkers();
    // ZLogger.info('GYMs POOL : ${gyms.first.toJson()}');
  }

  Future<Uint8List> _loadCustomMarkerIcon() async {
    ByteData data =
        await rootBundle.load('assets/map_styles/location-pin-v1.png');
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: 150);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> fetchCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ZLogger.error('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ZLogger.error('Location permissions are denied');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ZLogger.error(
          'Location permissions are permanently denied, we cannot request permissions.');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    userLocation.value = await LatLng(position.latitude, position.longitude);
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      showDragHandle: true,
      builder: (BuildContext context) {
        return GymBottomSheet(
          gyms: gyms,
          userLocation: Position(
            longitude: userLocation.value.longitude,
            latitude: userLocation.value.latitude,
            timestamp: DateTime.now(),
            accuracy: 0.0,
            altitude: 0.0,
            heading: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0,
            altitudeAccuracy: 0.0,
            headingAccuracy: 0.0,
          ),
          onGymSelected: (latitude, longitude) {
            Get.back();
            googleMapController?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(latitude, longitude),
                  zoom: 15.0,
                ),
              ),
            );
          },
        );
      },
    );
  }

  // void showButtomSheet(BuildContext context) async {
  //   final List<int> distanceOptions = [1, 2, 3, 4, 5]; // 1-5KM options
  //   int selectedDistance = 1; // Default selected distance
  //
  //   List<GymOwnerModel> nearbyGyms = gyms.where((gym) {
  //     if (gym.location == null) return false;
  //     double distanceInMeters = Geolocator.distanceBetween(
  //       userLocation.value.latitude,
  //       userLocation.value.longitude,
  //       gym.location!.latitude,
  //       gym.location!.longitude,
  //     );
  //     return distanceInMeters <= 1000; // 1KM radius
  //   }).toList();
  //
  //   showModalBottomSheet(
  //     context: context,
  //     enableDrag: true,
  //     showDragHandle: true,
  //     builder: (BuildContext context) {
  //       return nearbyGyms.isEmpty
  //           ? SizedBox(
  //               height: 170,
  //               child: Center(
  //                 child: Column(
  //                   children: [
  //                     const Icon(
  //                       Iconsax.info_circle,
  //                       size: 80,
  //                     ),
  //                     const SizedBox(
  //                       height: ZSizes.spaceBtwItems,
  //                     ),
  //                     Text(
  //                       'No Nearby Location',
  //                       style: Theme.of(context).textTheme.titleMedium,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             )
  //           : SizedBox(
  //               height: 250,
  //               child: Column(
  //                 children: [
  //                   Padding(
  //                     padding: EdgeInsets.symmetric(horizontal: ZSizes.sm),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           'Distance: ',
  //                           style: Theme.of(context).textTheme.headlineSmall,
  //                         ),
  //                         DropdownButton<int>(
  //                           value: selectedDistance,
  //                           onChanged: (int? newValue) {
  //                             // selectedDistance = newValue!;
  //                             // _filterGymsByDistance(selectedDistance);
  //                           },
  //                           items: distanceOptions
  //                               .map<DropdownMenuItem<int>>((int value) {
  //                             return DropdownMenuItem<int>(
  //                               value: value,
  //                               child: Text('$value KM'),
  //                             );
  //                           }).toList(),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   ListView.separated(
  //                     separatorBuilder: (_, __) => const SizedBox(
  //                       height: ZSizes.spaceBtwItems,
  //                     ),
  //                     shrinkWrap: true,
  //                     itemCount: nearbyGyms.length,
  //                     itemBuilder: (context, index) {
  //                       final gym = nearbyGyms[index];
  //                       return Card(
  //                         margin:
  //                             const EdgeInsets.symmetric(horizontal: ZSizes.sm),
  //                         color: ZHelperFunction.isDarkMode(context)
  //                             ? ZColor.dark
  //                             : ZColor.lightContainer,
  //                         child: ListTile(
  //                           onTap: () {
  //                             ZLogger.info(
  //                                 'Location ${gym.location!.latitude}');
  //                             Get.back();
  //                             googleMapController?.animateCamera(
  //                               CameraUpdate.newCameraPosition(
  //                                 CameraPosition(
  //                                   target: LatLng(gym.location!.latitude,
  //                                       gym.location!.longitude),
  //                                   zoom: 15.0,
  //                                 ),
  //                               ),
  //                             );
  //                           },
  //                           title: Text(gym.gymName.toString()),
  //                           subtitle: Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Text(gym.address.toString()),
  //                               Row(
  //                                 mainAxisSize: MainAxisSize.min,
  //                                 children: [
  //                                   const Icon(
  //                                     Iconsax.star5,
  //                                     color: Colors.amber,
  //                                     size: 24,
  //                                   ),
  //                                   const SizedBox(
  //                                     width: ZSizes.spaceBtwItems / 2,
  //                                   ),
  //                                   Text.rich(
  //                                     TextSpan(
  //                                       children: [
  //                                         TextSpan(
  //                                             text: gym.ratings.toString(),
  //                                             style: Theme.of(context)
  //                                                 .textTheme
  //                                                 .bodyLarge),
  //                                         TextSpan(
  //                                             text:
  //                                                 ' (${gym.visitors!.length})')
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ],
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   )
  //                 ],
  //               ),
  //             );
  //     },
  //   );
  // }

  // showButtomSheet(
  //   BuildContext context,
  // ) {
  //   return showModalBottomSheet(
  //       context: context,
  //       enableDrag: true,
  //       showDragHandle: true,
  //       builder: (BuildContext context) {
  //         return gyms.isEmpty
  //             ? SizedBox(
  //                 height: 170,
  //                 child: Center(
  //                   child: Column(
  //                     children: [
  //                       const Icon(
  //                         Iconsax.info_circle,
  //                         size: 80,
  //                       ),
  //                       const SizedBox(
  //                         height: ZSizes.spaceBtwItems,
  //                       ),
  //                       Text(
  //                         'No Nearby Location',
  //                         style: Theme.of(context).textTheme.titleMedium,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               )
  //             : SizedBox(
  //                 height: 250,
  //                 child: ListView.separated(
  //                   separatorBuilder: (_, __) => const SizedBox(
  //                     height: ZSizes.spaceBtwItems,
  //                   ),
  //                   itemCount: gyms.length,
  //                   itemBuilder: (context, index) {
  //                     final gym = gyms.value[index];
  //                     return Card(
  //                       margin:
  //                           const EdgeInsets.symmetric(horizontal: ZSizes.sm),
  //                       color: ZHelperFunction.isDarkMode(context)
  //                           ? ZColor.dark
  //                           : ZColor.lightContainer,
  //                       child: ListTile(
  //                         onTap: () {
  //                           ZLogger.info('Location ${gym.location!.latitude}');
  //                           Get.back();
  //                           googleMapController?.animateCamera(
  //                             CameraUpdate.newCameraPosition(
  //                               CameraPosition(
  //                                 target: LatLng(gym.location!.latitude,
  //                                     gym.location!.longitude),
  //                                 zoom: 15.0,
  //                               ),
  //                             ),
  //                           );
  //                         },
  //                         title: Text('${gym.gymName} GYM'),
  //                         subtitle: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Text(gym.address.toString()),
  //                             Row(
  //                               mainAxisSize: MainAxisSize.min,
  //                               children: [
  //                                 const Icon(
  //                                   Iconsax.star5,
  //                                   color: Colors.amber,
  //                                   size: 24,
  //                                 ),
  //                                 const SizedBox(
  //                                   width: ZSizes.spaceBtwItems / 2,
  //                                 ),
  //                                 Text.rich(TextSpan(children: [
  //                                   TextSpan(
  //                                       text: gym.ratings.toString(),
  //                                       style: Theme.of(context)
  //                                           .textTheme
  //                                           .bodyLarge),
  //                                   const TextSpan(text: '(8)')
  //                                 ])),
  //                               ],
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               );
  //       });
  // }

  scheduleDailyReset() {
    isAllowedToCheckIn.value = false;
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    final durationUntilMidnight = nextMidnight.difference(now);

    Timer(durationUntilMidnight, () {
      isAllowedToCheckIn.value = true;
    });
  }

  void checkOutFromGym(
      BuildContext context, String gymId, int oldRating, int oldVisits) {
    showDialog(
      context: context,
      builder: (_) {
        double newRating = 4;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: RatingBar.builder(
                    initialRating: 3,
                    itemCount: 5,
                    wrapAlignment: WrapAlignment.spaceEvenly,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: Colors.red,
                          );
                        case 1:
                          return Icon(
                            Icons.sentiment_dissatisfied,
                            color: Colors.redAccent,
                          );
                        case 2:
                          return Icon(
                            Icons.sentiment_neutral,
                            color: Colors.amber,
                          );
                        case 3:
                          return Icon(
                            Icons.sentiment_satisfied,
                            color: ZColor.primary.withOpacity(0.9),
                          );
                        case 4:
                          return Icon(
                            Icons.sentiment_very_satisfied,
                            color: ZColor.primary,
                          );
                        default:
                          return Icon(Iconsax.airdrop);
                      }
                    },
                    onRatingUpdate: (rating) {
                      newRating = rating;
                      ZLogger.info('New Rating: $newRating');
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Confirm Checkout',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Are you sure you want to check out from this gym?',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          // Perform the checkout action here
                          ZLogger.info('Checked out from gym: $gymId');
                          int newRatings =
                              oldRating + newRating.toInt() ~/ oldVisits;
                          GymScannerController.checkOut(gymId, newRatings);
                          // markCheckOut
                        },
                        child: const Text('Check Out'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
