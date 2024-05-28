import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_scout/features/authentication/screen/login_screen/login_screen.dart';
import 'package:fitness_scout/features/authentication/screen/onboard_screen/onboarding_screen.dart';
import 'package:fitness_scout/features/authentication/screen/signup_screen/verify_screen.dart';
import 'package:fitness_scout/features/personalization/screen/packages/landing_package_screen.dart';
import 'package:fitness_scout/utils/exceptions/firebase_auth_exception.dart';
import 'package:fitness_scout/utils/exceptions/firebase_exception.dart';
import 'package:fitness_scout/utils/exceptions/format_exception.dart';
import 'package:fitness_scout/utils/exceptions/plaform_exception.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    // _auth.signOut();
    // _auth.currentUser!.reload();


    if (_auth.currentUser != null) {
      if (_auth.currentUser!.emailVerified) {
        // Get.offAll(() => const NavigationMenu());
        Get.offAll(()=>const LandingPackageScreen());
      } else {
        Get.offAll(() => VerifyScreen(
              email: _auth.currentUser?.email,
            ));
      }
    } else {
      ZLogger.debug(deviceStorage.read('isFirstTime').toString());

      /// Local Storage
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(const LoginScreen())
          : Get.offAll(const OnBoardingScreen());
    }
  }

  // ------------------ Email & Password Sign-in -----------------------

  ///  [Email Authentication] - Sign-in
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///  [Email Authentication] - Register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///  [Email Authentication] - Send Email

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Email Authentication] - Forget Password;
  Future<void> sendPasswordResentEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///  [Social Authentication] - Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      /// --- Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      /// --- Obtain the auth detail from the request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      /// --- Create new credentials
      final credentials = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

      /// --- Once Sign in, return the user credentials
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///  [Email Authentication] - Logout

  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
