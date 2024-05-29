import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GymPoolController extends GetxController {
  static GymPoolController get instance => Get.find();

  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(30.3753, 69.3451),
    zoom: 14.4746,
  );

}
