import 'package:custom_info_window/custom_info_window.dart';
import 'package:fitness_scout/data/repositories/gym_pool/gym_pool_repository.dart';
import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui' as ui;
import '../../../utils/helpers/helper_functions.dart';
import '../model/gym_model.dart';

class GymPoolController extends GetxController {
  static GymPoolController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    loadGYMS();
    fetchCurrentLocation();
  }

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
                customInfoWindowController.value.addInfoWindow!(
                  Container(
                    height: 800,
                    width: 300,
                    decoration: BoxDecoration(
                      color: isDarkMode.value ? ZColor.dark : ZColor.white,
                      border: Border.all(
                          color: isDarkMode.value ? ZColor.white : ZColor.grey),
                      borderRadius:
                          BorderRadius.circular(ZSizes.borderRadiusLg),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 300,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(gym.images![0]),
                                  fit: BoxFit.fitWidth,
                                  filterQuality: FilterQuality.medium),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(
                              ZSizes.md,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    'ID: ${gym.id}',
                                    style: TextStyle(
                                        color: isDarkMode.value
                                            ? ZColor.white
                                            : ZColor.dark),
                                    softWrap: true,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    '${gym.gymName} GYM' ?? '',
                                    style: TextStyle(
                                        color: isDarkMode.value
                                            ? ZColor.white
                                            : ZColor.dark),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    'Description: ${gym.description}' ?? '',
                                    softWrap: true,
                                    style: TextStyle(
                                        color: isDarkMode.value
                                            ? ZColor.white
                                            : ZColor.dark),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  LatLng(gym.location!.latitude, gym.location!.longitude),
                );
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
}
