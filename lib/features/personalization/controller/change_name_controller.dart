import 'package:fitness_scout/features/personalization/controller/user_controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/constants/image_string.dart';
import '../../../utils/helpers/loaders.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../screen/profile/profile.dart';

class ChangeNameController extends GetxController {
  static ChangeNameController get instance => Get.find();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// Init user data when Home Screen appears
  @override
  void onInit() {
    super.onInit();
    initializeNames();
  }

  /// Fetch User Record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  /// Update User Name
  Future<void> updateUserName() async {
    try {
      FocusManager.instance.primaryFocus!.unfocus();

      // Start the Loader
      ZFullScreenLoader.openLoadingDialogy(
          'Processing your request...', ZImages.fileAnimation);

      // Check the value is updated
      if (firstName.text == userController.user.value.firstName &&
          lastName.text == userController.user.value.lastName) {
        ZLoaders.warningSnackBar(
            title: 'Warning', message: 'Please change name and Try Again');
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Update First & Last Name in Fire store
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim()
      };
      await UserRepository.instance.updateSingleField(name);

      // Update RX Values
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // Remove the Loader
      ZFullScreenLoader.stopLoading();

      // Show Success Message
      ZLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your Name has been updated');

      // Move Previous Screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      // Remove the Loader
      ZFullScreenLoader.stopLoading();
      ZLoaders.errorSnackBar(title: 'Uh Snap!', message: e.toString());
    }
  }
}
