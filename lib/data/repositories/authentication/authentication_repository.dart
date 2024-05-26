import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_scout/features/authentication/screen/login_screen/login_screen.dart';
import 'package:fitness_scout/features/authentication/screen/onboarding_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final _auth = FirebaseAuth.instance;

  /// --- Variables
  final deviceStorage = GetStorage();

  /// --- Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// --- Function to show relevant Screen
  screenRedirect() async {
    /// Local Storage
    deviceStorage.writeIfNull('isFirstTime', true);
    deviceStorage.read('isFirstTime') != true
        ? Get.offAll(const LoginScreen())
        : Get.offAll(const OnBoardingScreen());
  }


  // ------------------ Email & Password Sign-in -----------------------
  ///  [Email Authentication] - Sign-in

  ///  [Email Authentication] - Register
  Future<UserCredential> registerWithEmailAndPassword(String email, String password)async{
    try{
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch(e){
      throw 'Something Went Wrong. Please try again';
    }
  }




}