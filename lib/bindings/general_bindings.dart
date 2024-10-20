import 'package:fitness_scout/features/gym/controller/bmi/bmi_controller.dart';
import 'package:fitness_scout/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}
