import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool rememberMe = false.obs;

  final emailValidation = MultiValidator([
    EmailValidator(errorText: "Invalid Email"),
    RequiredValidator(errorText: "Required")
  ]);

  final passwordValidation = MultiValidator([
    RequiredValidator(errorText: 'Required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  ]);



}
