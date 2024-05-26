import 'package:fitness_scout/data/repositories/authentication/authentication_repository.dart';
import 'package:fitness_scout/data/repositories/user/user_repository.dart';
import 'package:fitness_scout/features/authentication/screen/signup_screen/reset_password.dart';
import 'package:fitness_scout/features/authentication/screen/signup_screen/verify_screen.dart';
import 'package:fitness_scout/utils/constants/image_string.dart';
import 'package:fitness_scout/utils/helpers/loaders.dart';
import 'package:fitness_scout/utils/helpers/network_manager.dart';
import 'package:fitness_scout/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables

  final signupFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  RxBool hidePassword = false.obs;
  RxBool privacyPolicy = false.obs;

  final nameValidator = MultiValidator([
    RequiredValidator(errorText: "Required"),
    MinLengthValidator(3, errorText: "Minimum 3 Words"),
    MaxLengthValidator(7, errorText: "Maximum 6 Words")
  ]);

  final usernameValidator = MultiValidator([
    RequiredValidator(errorText: "Required"),
    MinLengthValidator(5, errorText: "Minimum 5 Words"),
    MaxLengthValidator(12, errorText: "Maximum 10 Words")
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
        errorText: 'passwords must have at least one special character')
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

        Zloaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In Order to Create Account, you must have to read and accept the Privacy Policy & Terms of use.!');
        return;
      }

      // Register user in the Firebase Authentication & Save data in the firebase
      final userCredentials = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              emailController.text.trim(), passwordController.text.trim());

      /// Save Authenticated user data in the Firebase FireStore

      final userRepository = Get.put(UserRepository());
      final newUser = {
        'id': userCredentials.user!.uid,
        'name':
            '${firstNameController.text.trim()} ${lastNameController.text.trim()}',
        'username': userNameController.text.trim().toString(),
        'email': emailController.text.trim().toString(),
        'height': heightController.text.trim().toString(),
        'weight': weightController.text.trim().toString(),
        'phoneNo': phoneNumberController.text.trim().toString(),
        'profilePictue': ''
      };
      userRepository.saveUserRecord(newUser);

      /// Remove Loader
      ZFullScreenLoader.stopLoading();

      // Show Successor Message
      Zloaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! Verify email to continue');

      // Move To Verify Email Screen
      Get.to(() => const VerifyScreen());
    } catch (e) {
      //  Show some generic error to the user
      Zloaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      ZFullScreenLoader.stopLoading();
    }
  }

  void signupWithGoogle() {
    Get.showSnackbar(
      const GetSnackBar(
        title: "Error",
        message: "Google Authentication is under development!",
        duration: Duration(seconds: 3),
        isDismissible: true,
        icon: Icon(
          Icons.dangerous,
          color: Colors.red,
        ),
      ),
    );
  }

  void signupWithFacebook() {
    Get.showSnackbar(
      const GetSnackBar(
        title: "Error",
        message: "Facebook Authentication is under development!",
        duration: Duration(seconds: 3),
        isDismissible: true,
        icon: Icon(
          Icons.dangerous,
          color: Colors.red,
        ),
      ),
    );
  }

  // Forget Screen Things
  final forgetFormKey = GlobalKey<FormState>();

  void forgetPasswordButton() {
    FocusManager.instance.primaryFocus!.unfocus();
    if (forgetFormKey.currentState!.validate()) {
      Get.to(() => const ResetPassword());
    }
  }

  // Password Reset
  void resendEmailButton() {
    Get.snackbar("Email Resend", "Check Email!");
  }
}
