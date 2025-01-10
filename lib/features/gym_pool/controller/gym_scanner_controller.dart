import 'package:fitness_scout/data/repositories/gym_pool/gym_pool_repository.dart';
import 'package:fitness_scout/features/gym_pool/controller/gym_pool_controller.dart';

import 'package:fitness_scout/utils/helpers/loaders.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../utils/constants/image_string.dart';
import '../../../utils/device/deviceUtilities.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../model/gym_model.dart';

class GymScannerController extends GetxController {
  static GymScannerController get instance => Get.find();

  @override
  void onInit() {
    GymPoolController.instance.loadGYMS();
  }

  onDetectQR(final capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String scannedData = barcodes.first.rawValue ?? 'Unknown';
      _handleScannedData(Get.context, scannedData);
    }
  }

  void _handleScannedData(final context, String data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('QR Code Scanned!'),
        content: Text('Scanned Data: $data'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> markAttendance(String gymID, String gymName, String gymPhoneNo,
      GymType gymType, String gymLocation) async {
    try {
      final GymPoolController controller = Get.find();
      controller.loadLastCheckedInDate(); // Load the last checked-in date

      if (!controller.canCheckIn()) {
        ZLoaders.errorSnackBar(
            title: 'Already Checked In',
            message: 'You have already checked in today.');
        return;
      }

      Get.back();

      /// Start Loading
      ZFullScreenLoader.openLoadingDialogy(
          'We processing your information...', ZImages.fileAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        ZFullScreenLoader.stopLoading();
        ZLoaders.errorSnackBar(
            title: 'Internet Connection Failed',
            message:
                'Error while connecting internet. Please check and try again!');
        return;
      }

      await GymPoolRepository.instance.payToGym(gymID, gymType);
      await GymPoolRepository.instance.takeGYMAttendance(gymID);
      await GymPoolRepository.instance
          .takeUserAttendance(gymName, gymPhoneNo, gymLocation);

      ZDeviceUtils.playSound('sounds/success_notification.mp3');

      // Save today's date to prevent further check-ins today
      controller.saveLastCheckedInDate();
      await ZLoaders.successSnackBar(
          title: 'Attendance Confirmed!',
          message:
              'You are successfully checked in. Enjoy your workout session!');
    } catch (e) {
      ZLogger.error('Error : $e');
      ZLogger.warning('Error: $e');
      ZLoaders.errorSnackBar(title: 'Uh Snap!', message: e.toString());
    } finally {
      ZFullScreenLoader.stopLoading();
    }
  }

  static checkOut(String gymId, int newRating) async {
    try {
      // Start Loading
      ZFullScreenLoader.openLoadingDialogy(
          'We processing your information...', ZImages.fileAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        ZFullScreenLoader.stopLoading();
        ZLoaders.errorSnackBar(
            title: 'Internet Connection Failed',
            message:
                'Error while connecting internet. Please check and try again!');
        return;
      }

      GymPoolRepository.instance.markCheckOut(gymId, newRating);
      ZLoaders.successSnackBar(
          title: 'Successfully Checked Out',
          message: 'You may now leave the gym.');
    } catch (e) {
      ZLoaders.errorSnackBar(
          title: 'Uh Snap!',
          message: ' Something went wrong while checkout! Error: $e');
    } finally {
      ZFullScreenLoader.stopLoading();
    }
  }
}
