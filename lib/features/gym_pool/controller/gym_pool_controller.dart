import 'package:fitness_scout/data/repositories/gym_pool/gym_pool_repository.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../../utils/helpers/helper_functions.dart';
import '../model/gym_model.dart';

class GymPoolController extends GetxController {
  static GymPoolController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    _loadCustomMarkerIcon().then((_) {
      loadGYMS();
      fetchCurrentLocation();
    });
  }

  BitmapDescriptor? customMarkerIcon;
  RxBool isDarkMode = ZHelperFunction.isDarkMode(Get.context!).obs;
  Rx<LatLng> userLocation = const LatLng(31.5204, 74.3587).obs;
  Set<Marker> markers = <Marker>{}.obs;
  RxList<GymOwnerModel> gyms = <GymOwnerModel>[].obs;
  final gymRepository = Get.put(GymPoolRepository());

  final CameraPosition initialPosition = const CameraPosition(
    target: LatLng(31.5204, 74.3587), // Default location
    zoom: 14.4746,
  );

  void _addSurroundingMarkers() {
    ZLogger.info('Adding ${gyms.length} gym markers.');
    gyms.forEach((gym) {
      if (gym.location != null) {
        markers.add(
          Marker(
            markerId: MarkerId(gym.id),
            icon: customMarkerIcon ?? BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              title: gym.gymName,
              snippet: gym.description,
            ),
            position: LatLng(gym.location!.latitude, gym.location!.longitude),
          ),
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
    ZLogger.info('GYMs POOL : ${gyms.first.toJson()}');
  }

  Future<void> _loadCustomMarkerIcon() async {
    customMarkerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        size: Size(Get.width * 0.2, Get.width * 0.2),
      ),
      'assets/map_styles/location-pin-v1.png',
    );
    if (customMarkerIcon != null) {
      ZLogger.info('Custom marker icon loaded successfully.');
    } else {
      ZLogger.error('Failed to load custom marker icon.');
    }
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
}
