import 'package:fitness_scout/data/repositories/bmi/bmi_repositoty.dart';
import 'package:fitness_scout/features/gym/controller/bmi/bmi_controller.dart';
import 'package:fitness_scout/features/gym/model/diet_plan/diet_plan.dart';
import 'package:fitness_scout/features/gym/screen/diet_plan/diet_plan.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/constants/image_string.dart';
import '../../../../utils/helpers/loaders.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';

class DietPlanController extends GetxController {
  static DietPlanController get instance => Get.find();

  final bmi = Get.put(BMIRepository());
  Rx<DietPlan> dietPlan = DietPlan.empty().obs;
  RxList dietTaken = [].obs;

  void generateDietPlan() async {
    ZLogger.info('Generating Diet Plan');
    FocusManager.instance.primaryFocus!.unfocus();

    // Todo: Start Loader
    ZFullScreenLoader.openLoadingDialogy(
        'Logging you in...', ZImages.fileAnimation);

    // Todo: Check Internet Connectivity
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      ZFullScreenLoader.stopLoading();
      ZLoaders.errorSnackBar(
          title: 'Internet Connection Failed',
          message:
              'Error while connecting internet. Please check and try again!');
      ZLogger.error('Internet Connection Failed!');
      return;
    }

    await fetchDietPlan();
    Get.off(const DietPlanScreen());
  }

  Future<void> fetchDietPlan() async {
    ZLogger.info('Fetching Diet Plan');

    try {
      String diet;
      double bmiValue = BmiController.instance.bmi.value;
      ZLogger.info('BMI: $bmiValue, ${bmiValue.runtimeType}');

      // Determine diet category based on BMI value
      if (bmiValue < 18.5) {
        diet = 'bmi_underweight';
      } else if (bmiValue >= 18.5 && bmiValue < 25) {
        diet = 'bmi_normal';
      } else if (bmiValue >= 25 && bmiValue < 30) {
        diet = 'bmi_overweight';
      } else {
        diet = 'bmi_obese';
      }

      final storage = GetStorage();
      final storedDietPlan = storage.read('fetchDietPlan');
      if (storedDietPlan == null) {
        final fetchedDietPlan = await bmi.getDietPlan(diet);
        if (fetchedDietPlan != null) {
          ZLogger.info('Generating Diet Plain');
          storage.write('fetchDietPlan', fetchedDietPlan);
          dietPlan.value = fetchedDietPlan;
        } else {
          ZLogger.error('No diet plan found for diet: $diet');
          dietPlan.value = DietPlan.empty();
        }
      } else {
        dietPlan.value = storedDietPlan;
      }
    } catch (e) {
      ZLogger.error('Error while fetching diet plan:', e);
      dietPlan.value = DietPlan.empty(); // Reset dietPlan to empty on error
    }
  }

  selectDiet(final food) async {
    if (dietTaken.contains(food)) {
      dietTaken.remove(food);
    } else {
      dietTaken.add(food);
    }
  }
}
