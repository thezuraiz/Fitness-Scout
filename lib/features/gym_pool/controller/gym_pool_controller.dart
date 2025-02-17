import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:fitness_scout/data/repositories/gym_pool/gym_pool_repository.dart';
import 'package:fitness_scout/features/gym_pool/controller/gym_scanner_controller.dart';
import 'package:fitness_scout/features/gym_pool/screen/gymProfileScreen.dart';
import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:ui' as ui;
import '../../../utils/helpers/helper_functions.dart';
import '../../personalization/controller/user_controller.dart';
import '../model/gym_model.dart';
import '../screen/gymBottomScreen.dart';

class GymPoolController extends GetxController {
  static GymPoolController get instance => Get.find();

  @override
  void onReady() async {
    super.onReady();
    ZLogger.info('Loader Active');
    isLoading.value = true;
    await loadGYMS();
    await fetchCurrentLocation();
    isLoading.value = false;
    ZLogger.info('Loader Removed');
  }

  static RxBool canCheckedOut = false.obs;
  BitmapDescriptor? customMarkerIcon;
  RxBool isDarkMode = ZHelperFunction.isDarkMode(Get.context!).obs;
  Rx<LatLng> userLocation = const LatLng(31.5204, 74.3587).obs;
  Set<Marker> markers = <Marker>{}.obs;
  RxList<GymOwnerModel> gyms = <GymOwnerModel>[].obs;
  final gymRepository = Get.put(GymPoolRepository());
  GoogleMapController? googleMapController;
  var lastCheckedInDate = ''.obs;
  RxBool isLoading = false.obs;

  /// This function will be called to load the last checked-in date from GetStorage
  void loadLastCheckedInDate() {
    final storage = GetStorage();
    lastCheckedInDate.value = storage.read('lastCheckedInDate') ?? '';
  }

  /// This function will be used to check if the user can mark attendance
  bool canCheckIn() {
    ZLogger.info('Checking Last Checked In');
    final today = DateTime.now().toString().split(' ')[0];
    final result = lastCheckedInDate.value != today;
    ZLogger.info(result.toString());
    return result;
  }

  /// This function will save the current date as the last checked-in date
  void saveLastCheckedInDate() {
    final storage = GetStorage();
    final today = DateTime.now().toString().split(' ')[0];
    storage.write('lastCheckedInDate', today);
    lastCheckedInDate.value = today;
    Get.reload();
  }

  Rx<CustomInfoWindowController> customInfoWindowController =
      CustomInfoWindowController().obs;

  final CameraPosition initialPosition = const CameraPosition(
    target: LatLng(31.5204, 74.3587), // Default location
    zoom: 14.4746,
  );

  void _addSurroundingMarkers() async {
    final userPackage = UserController.instance.user.value.currentPackage;
    ZLogger.info('Adding ${gyms.value.length} gym markers.');
    gyms.value.forEach((gym) async {
      ZLogger.info(
          'GYMS Validation: ${gym.location != null && gym.gymType.name == userPackage}');
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
    ZLogger.info('GYMs POOL : ${gyms.value.first.toJson()}');
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

    /// Remove the Loader
    isLoading.value = false;
    Get.reload();
    ZLogger.warning('Is Loading: ${isLoading.value}');
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
                          return const Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: Colors.red,
                          );
                        case 1:
                          return const Icon(
                            Icons.sentiment_dissatisfied,
                            color: Colors.redAccent,
                          );
                        case 2:
                          return const Icon(
                            Icons.sentiment_neutral,
                            color: Colors.amber,
                          );
                        case 3:
                          return Icon(
                            Icons.sentiment_satisfied,
                            color: ZColor.primary.withOpacity(0.9),
                          );
                        case 4:
                          return const Icon(
                            Icons.sentiment_very_satisfied,
                            color: ZColor.primary,
                          );
                        default:
                          return const Icon(Iconsax.airdrop);
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
                        Navigator.of(context).pop();
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
                          try {
                            // Close the dialog
                            Navigator.of(context).pop();

                            // Perform the checkout action here
                            ZLogger.info('Checked out from gym: $gymId');
                            int newRatings = oldRating +
                                newRating.toInt() ~/ (oldVisits + 1);
                            // markCheckOut
                            GymScannerController.checkOut(gymId, newRatings);
                            GymPoolController.canCheckedOut.value = false;
                            Get.reload();
                          } catch (e) {
                            ZLogger.error('Error: ${e}');
                          }
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
