import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../../utils/helpers/helper_functions.dart';

class GymPoolController extends GetxController {
  static GymPoolController get instance => Get.find();

  BitmapDescriptor? customMarkerIcon;
  RxBool isDarkMode = ZHelperFunction.isDarkMode(Get.context!).obs;

  @override
  void onInit() {
    super.onInit();
    _fetchCurrentLocation();
  }

  final CameraPosition initialPosition = const CameraPosition(
    target: LatLng(31.5204, 74.3587), // Default location
    zoom: 14.4746,
  );

  Rx<LatLng> userLocation =
      const LatLng(31.5204, 74.3587).obs; // Default location

  Future<String> loadMapStyle(BuildContext context) async {
    String fileName = isDarkMode.value
        ? 'assets/map_styles/dark_map_style.json'
        : 'assets/map_styles/light_map_style.json';

    try {
      String mapStyle = await rootBundle.loadString(fileName);
      ZLogger.info('Loaded Map Style: $mapStyle'); // Debugging print
      ZLogger.info('Current Theme: ${isDarkMode.value ? "Dark" : "Light"}');
      return mapStyle;
    } catch (e) {
      ZLogger.info('Error loading map style: $e');
      return 'Error loading map style: $e'; // Return empty string if there's an error
    }
  }

  Future<void> _loadCustomMarkerIcon() async {
    customMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(1, 1)),
      'assets/map_styles/location-v2.png', // Path to your custom marker image
    );
  }

  // Method to fetch the user's current location
  Future<void> _fetchCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ZLogger.error('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    // Check for location permissions
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

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Update userLocation
    userLocation.value = LatLng(position.latitude, position.longitude);
    _loadCustomMarkerIcon();
  }
}
