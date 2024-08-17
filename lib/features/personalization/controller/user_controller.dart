import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_scout/data/repositories/user/user_repository.dart';
import 'package:fitness_scout/utils/helpers/loaders.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  /// Save User data from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      // First Update Rx User and then if the user data is already store, If not store new data
      // await fetchUserRecord();
      // if (user.value.id.isEmpty) {
      if (userCredential != null) {
        // Format Data
        final username = userCredential.user!.displayName ?? '';

        // Map the data
        final user = UserModel(
            id: userCredential.user!.uid ?? '',
            firstName:
                userCredential.user!.displayName!.split(' ')[0].toString(),
            lastName:
                userCredential.user!.displayName!.split(' ').toString()[1],
            userName: username,
            email: userCredential.user!.email ?? '',
            phoneNumber: userCredential.user!.phoneNumber ?? '',
            profilePicture: userCredential.user!.photoURL ?? '');

        // Save the Data
        await UserRepository.instance.saveUserRecord(user);
      }
      // }
    } catch (e) {
      ZLoaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your information. You can re save your data in your Profile.');
    }
  }
}
