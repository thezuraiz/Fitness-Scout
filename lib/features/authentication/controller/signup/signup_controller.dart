import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_scout/data/repositories/authentication/authentication_repository.dart';
import 'package:fitness_scout/data/repositories/user/user_repository.dart';
import 'package:fitness_scout/features/authentication/screen/signup_screen/verify_screen.dart';
import 'package:fitness_scout/utils/constants/image_string.dart';
import 'package:fitness_scout/utils/helpers/bmi_calculator.dart';
import 'package:fitness_scout/utils/helpers/loaders.dart';
import 'package:fitness_scout/utils/helpers/network_manager.dart';
import 'package:fitness_scout/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../../personalization/model/user_model.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables

  final signupFormKey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();

  RxBool hidePassword = true.obs;
  RxBool privacyPolicy = false.obs;

  final nameValidator = MultiValidator([
    RequiredValidator(errorText: "Required"),
    MinLengthValidator(3, errorText: "Minimum 3 Digits"),
    MaxLengthValidator(7, errorText: "Maximum 6 Digits"),
    AlphabeticValidator(errorText: "Only alphabets are allowed"),
  ]);

  final usernameValidator = MultiValidator([
    RequiredValidator(errorText: "Required"),
    MinLengthValidator(5, errorText: "Minimum 5 Digits"),
    MaxLengthValidator(12, errorText: "Maximum 10 Digits")
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: "Required"),
    EmailValidator(errorText: "Invalid Email"),
  ]);

  final phoneNumberValidator = MultiValidator([
    RequiredValidator(errorText: "Required Validator"),
    MinLengthValidator(5, errorText: "Invalid Phone Number"),
    MaxLengthValidator(15, errorText: "Invalid Phone Number")
  ]);

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

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passDigits must have at least one special character')
  ]);

  /// --- SIGNUP
  signup() async {
    try {
      FocusManager.instance.primaryFocus!.unfocus();

      // Start Loading
      ZFullScreenLoader.openLoadingDialogy(
          'We processing your information...', ZImages.fileAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        ZFullScreenLoader.stopLoading();
        ZLoaders.errorSnackBar(
            title: 'Internet Connection Failed',
            message:
                'Error while connecting internet. Please check and try again!');
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        // Remove Loader
        ZFullScreenLoader.stopLoading();
        return;
      }

      /// Privacy Policy Check
      if (!privacyPolicy.value) {
        // Remove Loader
        ZFullScreenLoader.stopLoading();

        ZLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In Order to Create Account, you must have to read and accept the Privacy Policy & Terms of use.!');
        return;
      }

      // Register user in the Firebase Authentication & Save data in the firebase
      await AuthenticationRepository.instance.registerWithEmailAndPassword(
          email.text.trim(), password.text.trim());

      /// Save Authenticated user data in the Firebase FireStore

      final userRepository = Get.put(UserRepository());

      double bmi = BmiCalculator.calculateBMI(double.parse(height.text.trim()),
              0, double.parse(weight.text.trim())) ??
          0.0;
      final newUser = UserModel(
          id: FirebaseAuth.instance.currentUser!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          userName: userName.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '',
          height: double.parse(height.text.trim()),
          weight: double.parse(weight.text.trim()),
          bmi: bmi);
      userRepository.saveUserRecord(newUser);

      /// Remove Loader
      ZFullScreenLoader.stopLoading();

      // Show Successor Message
      ZLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! Verify email to continue');

      // Move To Verify Email Screen
      Get.to(
        () => VerifyScreen(email: email.text.trim().toString()),
      );
    } catch (e) {
      //  Show some generic error to the user
      ZLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      ZFullScreenLoader.stopLoading();
    }
  }

  void signupWithFacebook() {
    ZLoaders.warningSnackBar(
        title: 'Error',
        message: 'Facebook Authentication is under development');
  }
}

class AlphabeticValidator extends TextFieldValidator {
  // Pass the error text to the super constructor
  AlphabeticValidator({String errorText = 'Only alphabets are allowed'})
      : super(errorText);

  @override
  bool isValid(String? value) {
    // Return true if the value consists of only alphabets
    return hasMatch(r'^[a-zA-Z]+$', value!);
  }
}
