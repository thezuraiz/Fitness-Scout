import 'dart:async';
import 'dart:math';
import 'package:fitness_scout/features/gym_pool/controller/gym_pool_controller.dart';
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

        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: location,
            // tilt: 0.2,
          ),
          onMapCreated: (GoogleMapController mapController) {
            controller0.complete(mapController);
          },
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          myLocationButtonEnabled: false,
          markers: <Marker>{
            Marker(
              markerId: const MarkerId('markerId'),
              // Unique ID for the marker
              position: LatLng(location.latitude + latOffset,
                  location.longitude + lngOffset),
              // Use userLocation for marker position
              infoWindow: const InfoWindow(
                title: 'Your Location',
                snippet: 'This is where you are.',
              ),
            ),
          },
          onCameraIdle: () async {
            if (location != controller.initialPosition.target) {
              final GoogleMapController mapController =
                  await controller0.future;
              mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: controller.userLocation.value,
                    zoom: 14.4746,
                  ),
                ),
              );
            }
          },
        );
      }),
    );
  }
}
