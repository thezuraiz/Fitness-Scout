import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_scout/features/authentication/screen/login_screen/login_screen.dart';
import 'package:fitness_scout/features/authentication/screen/onboarding_screen.dart';
import 'package:fitness_scout/utils/exceptions/firebase_auth_exception.dart';
import 'package:fitness_scout/utils/exceptions/firebase_exception.dart';
import 'package:fitness_scout/utils/exceptions/format_exception.dart';
import 'package:flutter/services.dart';
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
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    } on FirebaseException catch (e) {
      throw FirebaseException(
          plugin: e.plugin, code: e.code, message: e.message);
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: e.message);
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///  [Email Authentication] - Email

  Future<void> sendEmailVerification() async {
    try{
      await _auth.currentUser!.sendEmailVerification();
    }on FirebaseAuthException catch(e){
      throw ZFirebaseAuthException(e.code).message;
    }on FirebaseException catch(e){
      throw ZFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw ZFormatException();
    }
  }
}
