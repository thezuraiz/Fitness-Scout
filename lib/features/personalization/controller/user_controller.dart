import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_scout/data/repositories/user/user_repository.dart';
import 'package:fitness_scout/utils/helpers/loaders.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:get/get.dart';

class UserController extends GetxController{
  static UserController get instance => Get.find();

  /// --- VARIABLES
  Future<void> saveUserRecord (UserCredential? userCredentials)async{
    try{}catch(e){
      ZLoaders.warningSnackBar(title: 'Data Not Saved',message: 'Something went wrong while saving your information. You can re-save your data in your profile.');
      // Schema
      final newUser = {
        'id': userCredentials?.user!.uid ?? '',
        'name':
        userCredentials?.user!.displayName ?? '',
        'username': userCredentials?.user!.email ?? '',
        'email': userCredentials?.user!.email ?? '',
        'height': '',
        'weight': '',
        'phoneNo': userCredentials?.user!.phoneNumber ?? '',
        'profilePictue': userCredentials?.user!.photoURL ?? ''
      };

      // - Save User Record
      UserRepository.instance.saveUserRecord(newUser);

        }
  }

}