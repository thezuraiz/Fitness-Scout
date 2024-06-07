import 'package:fitness_scout/data/repositories/authentication/authentication_repository.dart';
import 'package:fitness_scout/features/authentication/screen/signup_screen/reset_password.dart';
import 'package:fitness_scout/utils/constants/image_string.dart';
import 'package:fitness_scout/utils/helpers/loaders.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:fitness_scout/utils/helpers/network_manager.dart';
import 'package:fitness_scout/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// --- VARIABLES
  final email = TextEditingController();
  final forgetKey = GlobalKey<FormState>();

  /// --- Form Validation
  final emailValidation =  MultiValidator([
        RequiredValidator(errorText: 'Required'),
        EmailValidator(errorText: 'Invalid Email')
      ]);

  /// --- Sent Resent Password Email
  sendPasswordResendEmail() async {
    try {
      // Todo: Remove Keyboard
      FocusManager.instance.primaryFocus!.unfocus();

      // Todo: Start Loader
      ZFullScreenLoader.openLoadingDialogy(
          'Processing your request...', ZImages.fileAnimation);

      // Todo: Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Todo: Form Validation
      if (!forgetKey.currentState!.validate()) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Todo: Send Email
      await AuthenticationRepository.instance.sendEmailVerification;

      // Todo: Stop Loader
      ZFullScreenLoader.stopLoading();

      // Todo: Show Success Screen
      await ZLoaders.successSnackBar( title: 'Email Sent', message: 'Email Link Sent To Reset Your Password');

      // Todo: Redirect
      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      ZFullScreenLoader.stopLoading();
      ZLoaders.errorSnackBar(title: 'Uh Snap!', message: e.toString());
    }
  }

  resendPasswordResendEmail(String email) async {
    try {
      // Todo: Remove Keyboard
      FocusManager.instance.primaryFocus!.unfocus();

      // Todo: Start Loader
      ZFullScreenLoader.openLoadingDialogy('Processing your request...', ZImages.fileAnimation);


      // Todo: Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Todo: Send Email
      await AuthenticationRepository.instance.sendEmailVerification;

      // Todo: Stop Loader
      ZFullScreenLoader.stopLoading();

      // Todo: Show Success Screen
      await ZLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email Link Sent To Reset Your Password');

    } catch (e) {
      ZFullScreenLoader.stopLoading();
      ZLoaders.errorSnackBar(title: 'Uh Snap!', message: e.toString());
    }
  }
}
