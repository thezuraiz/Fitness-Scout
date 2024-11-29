import 'package:fitness_scout/data/repositories/user/user_repository.dart';
import 'package:fitness_scout/features/personalization/controller/user_controller.dart';
import 'package:fitness_scout/utils/helpers/bmi_calculator.dart';
import 'package:fitness_scout/utils/helpers/loaders.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/helpers/network_manager.dart';

class BmiController extends GetxController {
  static BmiController get instance => Get.find();

  /// VARIABLES
  RxDouble bmi = 0.0.obs;

  final weight = TextEditingController();
  final heightInFeet = TextEditingController();
  final heightInInches = TextEditingController();
  final bmiKey = GlobalKey<FormState>();
  final userController = UserController.instance;
  final RxBool showDietPlan = false.obs;

  final heightInInchsValidator = MultiValidator([
    RequiredValidator(errorText: "Required Validator"),
    RangeValidator(
      min: 0,
      max: 12,
      errorText: 'Height must be between 0 and 12',
    ),
  ]);

  final heightInFeetValidator = MultiValidator([
    RequiredValidator(errorText: "Required Validator"),
    RangeValidator(
      min: 0,
      max: 9,
      errorText: 'Height must be between 0 and 9',
    ),
  ]);

  final weightValidator = MultiValidator([
    RequiredValidator(errorText: "Required Validator"),
    RangeValidator(
      min: 1,
      max: 150,
      errorText: 'Weight must be between 1 and 150',
    ),
  ]);

  /// --- Calculate BMI
  void calculateBMI() async {
    try {
      showDietPlan.value = false;
      // TODO: REMOVE KEYBOARD
      FocusManager.instance.primaryFocus!.unfocus();

      // TODO: VALIDATION
      if (!bmiKey.currentState!.validate()) {
        return;
      }

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZLoaders.errorSnackBar(
            title: 'Internet Connection Failed',
            message:
                'Error while connecting internet. Please check and try again!');
        return;
      }

      // TODO: CALCULATE BMI
      var weightText = weight.text.trim();
      var heightInFeetText = heightInFeet.text.trim();
      var heightInInchesText = heightInInches.text.trim();

      bmi.value = BmiCalculator.calculateBMI(double.parse(heightInFeetText),
          double.parse(heightInInchesText), double.parse(weightText));

      ZLogger.info('BMI: ${bmi.value}');

      final storage = GetStorage();
      storage.remove('fetchDietPlan');
      showDietPlan.value = true;

      Map<String, dynamic> json = {"bmi": bmi.value};
      await UserRepository.instance.updateSingleField(json);
      userController.user.value.bmi = bmi.value;
      userController.user.refresh();
    } catch (e) {
      ZLoaders.errorSnackBar(
          title: 'Uh Snap!',
          message:
              'Something went wrong while saving you bmi. Please try again.');
      ZLogger.error(e.toString());
    }
  }
}
