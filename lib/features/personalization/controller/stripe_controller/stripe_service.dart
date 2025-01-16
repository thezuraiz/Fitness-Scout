import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_scout/common/widgets/success_screen/successScreens.dart';
import 'package:fitness_scout/utils/constants/image_string.dart';
import 'package:fitness_scout/utils/helpers/loaders.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import '../../../../const.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/navigation_menu.dart';
import '../../../../utils/popups/full_screen_loader.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<void> makePayment(int amount, String packageName) async {
    ZLogger.info('Amount: $amount');
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        return;
      }
      String? paymentIntentClientSecrets =
          await _createPaymentIntent(amount, 'PKR');
      if (paymentIntentClientSecrets == null) return;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecrets,
          merchantDisplayName: 'Zuraiz Khan',
        ),
      );
      await _processPayment(
          amount, 'PKR', paymentIntentClientSecrets, packageName);
    } catch (e) {
      ZLogger.error('Error: $e');
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        'amount': _calculateAmount(amount),
        'currency': currency
      };

      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": 'Bearer $stripeSecretKey'},
        ),
      );
      if (response.data != null) {
        ZLogger.info('Data: ${response.data}');

        return response.data['client_secret'];
      }
      return null;
    } on DioException catch (e) {
      ZLogger.error('Error: ${e.response?.data}');
    } catch (e) {
      ZLogger.error('Error: $e');
    }
  }

  Future<void> _processPayment(int amount, String currency,
      final paymentIntentClientSecret, String packageName) async {
    ZLogger.info('In _process Payment Function!');
    try {
      await Stripe.instance.presentPaymentSheet();
      ZLogger.info('After _process Payment Function!');
      try {
        /// Save the Transaction
        final currentUser = FirebaseAuth.instance.currentUser;

        DocumentReference userDoc = FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser?.uid);

        Map<String, dynamic> newTransaction = {
          'amount': amount.toString(),
          'currency': currency,
          'timestamp': DateTime.now().toString(),
          'packageName': packageName
        };

        await userDoc.set({
          'packageHistory': FieldValue.arrayUnion([newTransaction]),
        }, SetOptions(merge: true));

        userDoc.update({'currentPackage': packageName});
        await ZLoaders.successSnackBar(
            title: 'Congratulations!', message: 'Your Transaction Successful');
        await Get.to(
          SuccessScreen(
            image: ZImages.successScreenAnimation,
            title: "Verification Complete",
            subTitle:
                "Transaction successful! You are now part of our family. Enjoy all the features of the Fitness Scout.",
            onPressed: () => Get.offAll(const NavigationMenu()),
          ),
        );
      } catch (e) {
        ZLogger.error('Failed to save transaction: ${e.toString()}');
      }
      await Stripe.instance.confirmPaymentSheetPayment();
    } catch (e) {
      ZLogger.error('Error $e');
    }
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
