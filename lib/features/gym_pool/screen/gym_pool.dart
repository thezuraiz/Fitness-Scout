import 'dart:async';
import 'dart:math';
import 'package:fitness_scout/features/gym_pool/controller/gym_pool_controller.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GymPool extends StatelessWidget {
  const GymPool({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GymPoolController());
    Completer<GoogleMapController> controller0 = Completer();
    
    return Scaffold(
      body: Obx(() {
        final location = controller.userLocation.value;

        double angle = 360 * (3.14159 / 180); // Convert to radians

        double radius = 500;
        // Calculate the latitude and longitude offsets
        double latOffset =
            (radius / 111320) * cos(angle); // Approximate latitude offset
        double lngOffset = (radius / 111320) *
            sin(angle) /
            cos(location.latitude *
                (3.14159 / 180)); // Approximate longitude offset

        return SafeArea(
          child: FutureBuilder(
              future: controller.loadMapStyle(context),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: location,
                    zoom: 16,
                  ),
                  onMapCreated: (GoogleMapController mapController) async {
                    controller0.complete(mapController);
                    String mapStyle = await controller.loadMapStyle(context);
                    mapController.setMapStyle(mapStyle);
                  },
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: <Marker>{
                    Marker(
                      markerId: const MarkerId('markerId'),
                      position: LatLng(location.latitude + latOffset,
                          location.longitude + lngOffset),
                      infoWindow: const InfoWindow(
                        title: 'GYM Name',
                        snippet: 'GYM Description',
                      ),
                      icon: controller.customMarkerIcon ??
                          BitmapDescriptor.defaultMarker,
                      onTap: () {
                        ZLogger.info('Marker tapped');
                      },
                    ),
                  },
                  onCameraIdle: () async {
                    if (location != controller.initialPosition.target) {}
                  },
                );
              }),
        );
      }),
    );
  }
}
