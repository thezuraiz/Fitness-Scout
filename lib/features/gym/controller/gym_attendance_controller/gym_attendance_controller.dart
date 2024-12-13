import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_scout/data/repositories/user/user_repository.dart';
import 'package:fitness_scout/features/personalization/controller/user_controller.dart';
import 'package:fitness_scout/features/personalization/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/helpers/loaders.dart';
import '../../../../utils/helpers/logger.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';

class GymAttendanceController extends GetxController {
  static GymAttendanceController get instance => Get.find();

  @override
  void onInit() async {
    super.onInit();
    userGYMAttendance.value = UserController.instance.user.value.userAttendance;
    ZLogger.info('${userGYMAttendance.value}');
  }

  RxList<GymUserAttendance> userGYMAttendance = <GymUserAttendance>[].obs;
  final _userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> loadUserAttendance() async {
    try {
      ZLogger.info('Load User Attendance');

      // Todo: Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        ZLoaders.errorSnackBar(
            title: 'Internet Connection Failed',
            message:
                'Error while connecting internet. Please check and try again!');
        ZLogger.error('Internet Connection Failed!');
        return;
      }

      final DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('Users')
          .doc(_userId)
          .get();
      Map<String, dynamic> data = userData.data() as Map<String, dynamic>;
      List<dynamic> userAttendanceList = data['userAttendance'];
      userGYMAttendance.value = userAttendanceList
          .map((item) => GymUserAttendance.fromMap(item))
          .toList();

      ZLogger.info('UserData: ${userGYMAttendance.value}');
    } catch (e) {
      ZLogger.error('Errors: $e');
    }
  }
}
