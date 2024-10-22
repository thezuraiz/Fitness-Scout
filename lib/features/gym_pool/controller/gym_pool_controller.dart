import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GymPoolController extends GetxController {
  static GymPoolController get instance => Get.find();

  final CameraPosition initialPosition = const CameraPosition(
    target: LatLng(31.5204, 74.3587), // Default location
    zoom: 14.4746,
  );

  Rx<LatLng> userLocation =
      const LatLng(31.5204, 74.3587).obs; // Default location

  @override
  void onInit() {
    super.onInit();
    _fetchCurrentLocation();
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
  }
}
