import 'package:fitness_scout/features/authentication/screen/signup_screen/reset_password.dart';
import 'package:fitness_scout/features/authentication/screen/signup_screen/verify_screen.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Sign Up Page Items

  final signupFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool showPassword = false.obs;

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

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  RxBool iAgreeTo = false.obs;


  void createAccountButton(){
    FocusManager.instance.primaryFocus!.unfocus();
    if(signupFormKey.currentState!.validate()){
      if(iAgreeTo.value == false){
        Get.snackbar("Validation Error", "Must Agree Terms and Condition");
        return;
      }
      Get.off(const VerifyScreen());
    }
  }


  void signupWithGoogle() {
    Get.showSnackbar(
      const GetSnackBar(
        title: "Error",
        message: "Google Authentication is under development!",
        duration: Duration(seconds: 3),
        isDismissible: true,
        icon: Icon(Icons.dangerous,color: Colors.red,),
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
        icon: Icon(Icons.dangerous,color: Colors.red,),
      ),
    );
  }


  // Forget Screen Things
  final forgetFormKey = GlobalKey<FormState>();

  void forgetPasswordButton(){
    FocusManager.instance.primaryFocus!.unfocus();
    if(forgetFormKey.currentState!.validate()){
      Get.to( () => const ResetPassword());
    }
  }

  // Password Reset
  void resendEmailButton(){
    Get.snackbar("Email Resend", "Check Email!");
  }

}
