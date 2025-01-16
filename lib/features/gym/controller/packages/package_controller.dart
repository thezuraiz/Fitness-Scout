import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_scout/features/personalization/controller/user_controller.dart';
import 'package:fitness_scout/features/personalization/model/user_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../utils/exceptions/firebase_exception.dart';
import '../../../../utils/exceptions/format_exception.dart';
import '../../../../utils/helpers/loaders.dart';
import '../../../../utils/helpers/logger.dart';

class PackageController extends GetxController {
  static PackageController get instance => Get.find();
  RxBool isPackageLoading = false.obs;

  RxList<PackageHistory> packageHistory =
      (UserController.instance.user.value.packageHistory.obs.reversed.toList())
          .obs;

  Future<void> reloadPackages() async {
    try {
      ZLogger.info('Fetching Packages');
      isPackageLoading.value = true;
      final packages = await fetchPackages();
      this.packageHistory(packages);
      ZLogger.info('Fetching packages length: ${packages.length}');
    } catch (e) {
      ZLoaders.errorSnackBar(
          title: 'Something went wrong ',
          message: 'While fetching Upcoming Events');
    } finally {
      await Future.delayed(const Duration(seconds: 1));
      isPackageLoading.value = false;
    }
  }

  Future<List<PackageHistory>> fetchPackages() async {
    try {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (documentSnapshot.exists) {
        final data = documentSnapshot.data() as Map<String, dynamic>;

        if (data.containsKey('packageHistory')) {
          List packageHistoryList = data['packageHistory'];

          final packageList = packageHistoryList.map((item) {
            return PackageHistory.fromJson(item as Map<String, dynamic>);
          }).toList();

          return packageList;
        } else {
          ZLogger.error('Package history not found in the document');
          return [];
        }
      } else {
        ZLogger.error('Document not found');
        return [];
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
