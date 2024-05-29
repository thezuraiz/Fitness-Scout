import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GymPoolController extends GetxController {
  static GymPoolController get instance => Get.find();

  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(31.5204, 74.3587),
    zoom: 14.4746,
  );

}
