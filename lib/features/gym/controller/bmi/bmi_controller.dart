import 'package:flutter/cupertino.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class BmiController extends GetxController {
  static BmiController get instance => Get.find();

  /// VARIABLES
  var bmiMessage = ''.obs;
  RxDouble bmi = 0.0.obs;
  final weight = TextEditingController();
  final height = TextEditingController();
  final bmiKey = GlobalKey<FormState>();

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
  void calculateBMI() {
    // TODO: REMOVE KEYBOARD
    FocusManager.instance.primaryFocus!.unfocus();

    // TODO: VALIDATION
    if(bmiKey.currentState!.validate()){

      // TODO: CALCULATE BMI
      var weightText = weight.text.toString();
      var heightText = height.text.toString();

      if (weightText.isNotEmpty && heightText.isNotEmpty) {
        var iW = double.parse(weightText);
        var iH = double.parse(heightText) / 3.281;
        bmi.value = iW / (iH * iH);

        if (bmi.value <= 18.5) {
          bmiMessage.value = "Weak";
        } else if (bmi.value <= 25) {
          bmiMessage.value = "Healthy";
        } else if (bmi.value > 25) {
          bmiMessage.value = "Overweight";
        }
      } else {
        bmiMessage.value = "Please fill all required text fields";
      }
    }

  }
}
