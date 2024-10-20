import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_scout/features/gym/model/diet_plan/diet_plan.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_exception.dart';
import '../../../utils/exceptions/format_exception.dart';

class BMIRepository extends GetxController {
  static BMIRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Functions to fetch Diet Plan details based on user id
  Future<DietPlan> getDietPlan(final dietPlanCategory) async {
    try {
      DocumentSnapshot snapshot =
          await _db.collection('dietPlans').doc(dietPlanCategory).get();
      if (snapshot.exists) {
        return DietPlan.fromSnapshot(snapshot);
      } else {
        ZLogger.error('Something went wrong while Fetching');
        return DietPlan.empty();
      }
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZFormatException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
