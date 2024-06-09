import 'package:fitness_scout/data/repositories/authentication/authentication_repository.dart';
import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfilePageController extends GetxController {
  static ProfilePageController get instance => Get.find();

  /// ---- VARIABLE
  var geoLocation = true.obs;
  var safeMode = true.obs;
  var hdImages = true.obs;

  ///  --- FUNCTIONS
  void logout() {
    Get.dialog(
      AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () {
              AuthenticationRepository.instance.logout();
            },
            child: Text("Yes"),
            style: TextButton.styleFrom(textStyle: TextStyle(color: ZColor.primary)),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: Text("No"),
            style: TextButton.styleFrom(textStyle: TextStyle(color: ZColor.primary)),
          ),
        ],
      ),
    );
  }
}
