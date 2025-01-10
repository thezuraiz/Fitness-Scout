import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_scout/features/personalization/controller/user_controller.dart';
import 'package:fitness_scout/features/personalization/model/user_model.dart';
import 'package:get/get.dart';

import '../../../../utils/helpers/loaders.dart';
import '../../../../utils/helpers/logger.dart';
import '../../../../utils/helpers/network_manager.dart';

class GymAttendanceController extends GetxController {
  static GymAttendanceController get instance => Get.find();

  @override
  void onInit() async {
    super.onInit();
    userGYMAttendance.value =
        UserController.instance.user.value.userAttendance.reversed.toList();
    ZLogger.info('${userGYMAttendance.value}');
  }

  RxList<GymUserAttendance> userGYMAttendance = <GymUserAttendance>[].obs;
  final _userId = FirebaseAuth.instance.currentUser!.uid;
  RxBool isLoading = false.obs;

  Future<void> loadUserAttendance() async {
    try {
      isLoading.value = true;
      ZLogger.info('Loading User Attendance');

      // Todo: Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
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
          .toList()
          .reversed
          .toList();
      ZLogger.info(userGYMAttendance.value.toString());
      ZLogger.info(userGYMAttendance.value.length.toString());
      ZLogger.info('UserData: ${userGYMAttendance.value}');
      await Future.delayed(const Duration(seconds: 1));
      isLoading.value = false;
      ZLogger.info('Is Loading ${isLoading.value}');
    } catch (e) {
      isLoading.value = false;
      ZLogger.error('Errors: $e');
    }
  }
}
