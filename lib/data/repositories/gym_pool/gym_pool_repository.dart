import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_scout/features/gym_pool/model/gym_model.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_exception.dart';
import '../../../utils/exceptions/format_exception.dart';

class GymPoolRepository extends GetxController {
  static GymPoolRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<GymOwnerModel>> fetchGYMS() async {
    ZLogger.info('Fetching GYMS');
    try {
      final documentSnapshot = await _db.collection('Gyms').get();

      if (documentSnapshot.docs.isNotEmpty) {
        return documentSnapshot.docs.map((gym) {
          ZLogger.info('gym: ${gym.data()}');
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
}
