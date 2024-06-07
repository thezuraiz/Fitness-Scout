import 'package:fitness_scout/data/repositories/authentication/authentication_repository.dart';
import 'package:fitness_scout/features/personalization/controller/user_controller.dart';
import 'package:fitness_scout/utils/constants/image_string.dart';
import 'package:fitness_scout/utils/helpers/loaders.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:fitness_scout/utils/helpers/network_manager.dart';
import 'package:fitness_scout/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  @override
  void onInit() {
    email.text = deviceStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = deviceStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  /// --- Variables
  final email = TextEditingController();
  final password = TextEditingController();
  final rememberMe = true.obs;
  final hidePassword = true.obs;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final deviceStorage = GetStorage();

  final userController = Get.put(UserController());

  final emailValidation = MultiValidator([
    EmailValidator(errorText: "Invalid Email"),
    RequiredValidator(errorText: "Required")
  ]);

  /// --- Email & Password Sign In
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Todo: Remove Keyboard
      FocusManager.instance.primaryFocus!.unfocus();

      // Todo: Start Loader
      ZFullScreenLoader.openLoadingDialogy(
          'Logging you in...', ZImages.fileAnimation);

      // Todo: Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        ZLogger.error('Internet Connection Failed!');
        return;
      }

      // Todo: Form Validation
      if (!loginKey.currentState!.validate()) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Todo: Save Data if remember me is selected
      if (rememberMe.value) {
        deviceStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        deviceStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Todo: Login using email & password
      await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());


      // Todo: Welcome Message
      ZLoaders.successSnackBar(title: 'Welcome!', message: 'You are Login.');


      // Todo: Remove Loader
      ZFullScreenLoader.stopLoading();

      // Todo: Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      ZFullScreenLoader.stopLoading();
      ZLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      ZLogger.error(e.toString());
    }
  }

  /// --- Google Sign In
  Future<void> googleSignIn()async{
    try{
      // Todo: Remove Keyboard
      FocusManager.instance.primaryFocus!.unfocus();
      
      // Todo: Start Loader
      ZFullScreenLoader.openLoadingDialogy('Logging you in...', ZImages.fileAnimation);

      // Todo: Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Todo: Google Authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      // Todo: Save the data
      await userController.saveUserRecord(userCredentials);

      // Todo: Remove Loader
      ZFullScreenLoader.stopLoading();

    }catch(e){
      ZLoaders.errorSnackBar(title: 'Uh Snap!',message: e.toString());
      ZFullScreenLoader.stopLoading();
    }
  }

}
