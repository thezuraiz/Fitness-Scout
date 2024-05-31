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

    return GoogleMap(
      initialCameraPosition: controller.kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        controller0.complete(controller);
      },
      myLocationEnabled: true,
    );
  }
}
