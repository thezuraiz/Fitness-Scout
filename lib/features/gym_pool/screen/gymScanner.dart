import 'package:fitness_scout/features/gym_pool/controller/gym_scanner_controller.dart';
import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:fitness_scout/utils/helpers/loaders.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:get/get.dart';

class GymScanner extends StatelessWidget {
  const GymScanner(
      {super.key,
      required this.gymId,
      required this.gymName,
      required this.gymPhoneNo,
      required this.gymAddress,
      required this.gymRatings});

  final String gymId;
  final String gymName, gymPhoneNo, gymAddress;
  final int gymRatings;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GymScannerController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR for $gymName GYM',
            style: Theme.of(context).textTheme.headlineSmall),
        // backgroundColor: ZColor.primary,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: MobileScanner(
              controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.noDuplicates,
                facing: CameraFacing.back,
              ),
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty) {
                  final String scannedData =
                      barcodes.first.rawValue ?? 'Unknown';
                  controller.markAttendance(
                      scannedData, gymName, gymPhoneNo, gymAddress);
                }
              },
              onDetectError: (_, __) {
                ZLoaders.errorSnackBar(
                    title: 'Scanned Failed', message: 'Something Went Wrong');
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.qr_code_scanner,
                      size: 50,
                      color: ZColor.primary,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Point the camera at a QR Code',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
