import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_scout/utils/helpers/loaders.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../features/gym_pool/model/gym_model.dart';
import '../../../features/personalization/controller/user_controller.dart';
import '../../../features/personalization/model/user_model.dart';
import '../../../utils/exceptions/firebase_exception.dart';
import '../../../utils/exceptions/format_exception.dart';

class GymPoolRepository extends GetxController {
  static GymPoolRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _userID = FirebaseAuth.instance.currentUser!.uid;

  Future<List<GymOwnerModel>> fetchGYMS() async {
    ZLogger.info('Fetching GYMS');
    try {
      final documentSnapshot = await _db.collection('Gyms').get();

      if (documentSnapshot.docs.isNotEmpty) {
        return documentSnapshot.docs.map((gym) {
          ZLogger.info('gym: ${gym.data()}');
          print(gym.data()['opening_hours'].toString());
          return GymOwnerModel.fromSnapshot(gym);
        }).toList();
      } else {
        return [];
      }
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZFormatException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again $e';
    }
  }

  Future<void> takeUserAttendance(
      String gymName, String gymPhoneNo, String gymLocation) async {
    try {
      await FirebaseFirestore.instance.collection('Users').doc(_userID).update({
        'userAttendance': FieldValue.arrayUnion(
          [
            GymUserAttendance(
              id: _userID,
              phoneNo: gymPhoneNo,
              location: gymLocation,
              checkInTime: DateTime.now(),
              checkOutTime: DateTime.now().add(const Duration(hours: 1)),
              name: UserController.instance.user.value.firstName,
            ).toMap()
          ],
        ),
      });
    } catch (e) {
      throw 'Something went wrong while marking User attendance';
    }
  }

  Future<void> takeGYMAttendance(String gymID) async {
    try {
      await FirebaseFirestore.instance.collection('Gyms').doc(gymID).update({
        'visitors': FieldValue.arrayUnion(
          [
            GymUserAttendance(
              id: _userID,
              checkInTime: DateTime.now(),
              checkOutTime: DateTime.now().add(const Duration(hours: 1)),
              name: UserController.instance.user.value.firstName,
            ).toMap()
          ],
        ),
      });
    } catch (e) {
      throw 'Something went wrong while marking GYM attendance';
    }
  }
}
