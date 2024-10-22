import 'dart:async';
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
                    await mapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: controller.userLocation.value,
                          zoom: 14.0,
                        ),
                      ),
                    );
                  },
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: controller.markers,
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
