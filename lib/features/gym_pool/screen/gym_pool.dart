import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:fitness_scout/features/gym_pool/controller/gym_pool_controller.dart';
import 'package:fitness_scout/features/gym_pool/screen/gymBottomScreen.dart';
import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';

class GymPool extends StatelessWidget {
  const GymPool({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GymPoolController());
    Completer<GoogleMapController> controller0 = Completer();

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Obx(() {
        final location = controller.userLocation.value;
        final infoWindowController =
            controller.customInfoWindowController.value;

        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SafeArea(
          child: Stack(
            children: [
              FutureBuilder(
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
                        controller.googleMapController = mapController;
                        String mapStyle =
                            await controller.loadMapStyle(context);
                        mapController.setMapStyle(mapStyle);
                        await mapController.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: controller.userLocation.value,
                              zoom: 14.0,
                            ),
                          ),
                        );
                        infoWindowController.googleMapController =
                            mapController;
                      },
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      zoomGesturesEnabled: true,
                      myLocationButtonEnabled: true,
                      markers: Set<Marker>.of(controller.markers),
                      onCameraIdle: () async {
                        if (location != controller.initialPosition.target) {}
                      },
                      onTap: (position) =>
                          infoWindowController.hideInfoWindow!(),
                      onCameraMove: (position) =>
                          infoWindowController.onCameraMove!(),
                    );
                  }),
              CustomInfoWindow(
                controller: infoWindowController,
                height: 150,
                width: 200,
                offset: 40,
              )
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          foregroundColor: ZColor.dark,
          child: const Icon(Iconsax.airdrop),
          onPressed: () {
            ZLogger.info('Gyms before ${controller.gyms.length}');
            showModalBottomSheet(
              context: context,
              enableDrag: true,
              showDragHandle: true,
              builder: (BuildContext context) {
                ZLogger.info(
                    'Gyms in ButtonSheet ${controller.gyms.first.name}');
                return GymBottomSheet(
                  gyms: controller.gyms,
                  userLocation: Position(
                    longitude: controller.userLocation.value.longitude,
                    latitude: controller.userLocation.value.latitude,
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
                    controller.googleMapController?.animateCamera(
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
          }),
    );
  }
}
