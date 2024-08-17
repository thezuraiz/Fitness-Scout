import 'package:fitness_scout/data/repositories/user/user_repository.dart';
import 'package:fitness_scout/features/personalization/controller/user_controller.dart';
import 'package:fitness_scout/utils/helpers/bmi_calculator.dart';
import 'package:fitness_scout/utils/helpers/loaders.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../utils/helpers/network_manager.dart';

class BmiController extends GetxController {
  static BmiController get instance => Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    bmi.value = 0;
  }

  /// VARIABLES
  static RxDouble bmi = 0.0.obs;
  final weight = TextEditingController();
  final height = TextEditingController();
  final bmiKey = GlobalKey<FormState>();
  final userController = UserController.instance;

  final heightValidator = MultiValidator([
    RequiredValidator(errorText: "Required Validator"),
    RangeValidator(
      min: 1,
      max: 15,
      errorText: 'Height must be between 1 and 15',
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
      var heightText = height.text.trim();

      bmi.value = BmiCalculator.calculateBMI(
          double.parse(heightText), double.parse(weightText));

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
