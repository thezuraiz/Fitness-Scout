import 'package:fitness_scout/data/repositories/gym_pool/gym_pool_repository.dart';
import 'package:fitness_scout/features/gym_pool/controller/gym_pool_controller.dart';

import 'package:fitness_scout/utils/helpers/loaders.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../utils/constants/image_string.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';

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

  Future<void> markAttendance(String gymID) async {
    try {
      Get.back();
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
      await GymPoolRepository.instance.takeGYMAttendance(gymID);
      await GymPoolRepository.instance.takeUserAttendance();
      await ZLoaders.successSnackBar(title: 'Attendance marked');
    } catch (e) {
      ZLogger.error('Error : $e');
      ZLogger.warning('Error: $e');
      ZLoaders.errorSnackBar(title: 'Invalid Data');
    } finally {
      ZFullScreenLoader.stopLoading();
    }
  }
}
