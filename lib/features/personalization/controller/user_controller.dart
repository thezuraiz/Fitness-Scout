import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_scout/data/repositories/user/user_repository.dart';
import 'package:fitness_scout/utils/helpers/loaders.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../utils/constants/image_string.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../authentication/screen/login_screen/login_screen.dart';
import '../model/user_model.dart';
import '../screen/profile/widgets/re_auth_user_login_form.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  /// VARIABLES
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  final profileLoading = false.obs;
  final imageUploading = false.obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  //// Ots not required due to login page its automatically calls, so I call it home header
  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  /// Fetch User Record
  Future<void> fetchUserRecord() async {
    ZLogger.info('Fetching User Records');
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      ZLogger.info('User Record Found! ${user.toJson().toString()}');
      this.user(user);
    } catch (e) {
      ZLogger.error('User Not found: $e');
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  uploadUserProfilePicture() async {
    try {
      ZLogger.info('Camera Open');
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      imageUploading.value = true;
      if (image != null) {
        // Upload Image to Cloud
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile/', image);

        // Update User Profile In Fire store
        Map<String, dynamic> json = {'profilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        // Update Profile Image in User Controller
        user.value.profilePicture = imageUrl;
        user.refresh();

        ZLoaders.successSnackBar(
            title: 'Congratulations',
            message: 'Your profile picture has been updated');
      }
    } catch (e) {
      ZLoaders.errorSnackBar(title: 'Uh Snap!', message: e.toString());
    } finally {
      imageUploading.value = false;
    }
  }

  /// Save User data from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      // First Update Rx User and then if the user data is already store, If not store new data
      await fetchUserRecord();
      if (user.value.id.isEmpty) {
        if (userCredential != null) {
          // Format Data
          final username = userCredential.user!.displayName ?? '';

          // Map the data
          final user = UserModel(
            id: userCredential.user!.uid ?? '',
            firstName: userCredential.user!.displayName?.split(' ')[0] ?? '',
            lastName: userCredential.user!.displayName!.split(' ').length > 1
                ? userCredential.user!.displayName!.split(' ')[1]
                : '',
            userName: username,
            email: userCredential.user!.email ?? '',
            phoneNumber: userCredential.user!.phoneNumber ?? '',
            profilePicture: userCredential.user!.photoURL ?? '',
            userAttendance: <GymUserAttendance>[],
          );

          // Save the Data
          await UserRepository.instance.saveUserRecord(user);
        }
      }
    } catch (e) {
      ZLoaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your information. You can re save your data in your Profile.');
    }
  }

  /// Delete Account Loading
  void deleteAccountWarningPopUp() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(ZSizes.md),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be permanently removed',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red)),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: ZSizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      /// Start Loader
      ZFullScreenLoader.openLoadingDialogy(
          'Processing your request...', ZImages.fileAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      /// First Re-Authenticate User
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        /// Re verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          ZFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          ZFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthUserLoginForm());
        }
      }
    } catch (e) {
      ZFullScreenLoader.stopLoading();
      ZLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailAndPassword() async {
    try {
      /// Start Loader
      ZFullScreenLoader.openLoadingDialogy(
          'Processing your request...', ZImages.fileAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      /// Validation on form
      if (!reAuthFormKey.currentState!.validate()) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      ZFullScreenLoader.stopLoading();
      Get.to(() => const LoginScreen());
    } catch (e) {
      ZFullScreenLoader.stopLoading();
      ZLoaders.warningSnackBar(title: 'Uh Snap!', message: e.toString());
    }
  }
}
