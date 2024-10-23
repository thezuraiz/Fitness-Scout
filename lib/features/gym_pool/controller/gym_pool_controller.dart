import 'dart:math';

import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../../utils/helpers/helper_functions.dart';

class GymPoolController extends GetxController {
  static GymPoolController get instance => Get.find();

  @override
  void onReady() {
    super.onReady();
    fetchCurrentLocation();
  }

  @override
  void onInit() {
    super.onInit();
    fetchCurrentLocation();
  }

  BitmapDescriptor? customMarkerIcon;
  RxBool isDarkMode = ZHelperFunction.isDarkMode(Get.context!).obs;
  Rx<LatLng> userLocation = const LatLng(31.5204, 74.3587).obs;
  Set<Marker> markers = <Marker>{}.obs;

  final CameraPosition initialPosition = const CameraPosition(
    target: LatLng(31.5204, 74.3587), // Default location
    zoom: 14.4746,
  );

  void _addSurroundingMarkers(LatLng centerLocation) {
    ZLogger.info('Adding Surrounding Locations');
    double radius = 1000;

    int markerCount = 6;

    for (int i = 0; i < markerCount; i++) {
      double angle = (i * (360 / markerCount)) * (3.14159 / 180);

      double latOffset = (radius / 111320) * cos(angle);
      double lngOffset = (radius / 111320) *
          sin(angle) /
          cos(centerLocation.latitude * (3.14159 / 180));

      LatLng newMarkerPosition = LatLng(
        centerLocation.latitude + latOffset,
        centerLocation.longitude + lngOffset,
      );

      markers.add(
        Marker(
          markerId: MarkerId('surrounding_marker_$i'),
          position: newMarkerPosition,
          icon: customMarkerIcon ?? BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
            title: 'Surrounding Location $i',
            snippet: 'This is a surrounding marker.',
          ),
        ),
      );
    }
    ZLogger.warning('Maps: ${markers}');
  }

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

  Future<void> _loadCustomMarkerIcon() async {
    customMarkerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        size: Size(Get.width * 0.2, Get.width * 0.2),
      ),
      'assets/map_styles/location-pin-v1.png',
    );
  }

  Future<void> fetchCurrentLocation() async {
    await _loadCustomMarkerIcon();
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
    _addSurroundingMarkers(userLocation.value);
  }
}
