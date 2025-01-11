import 'package:dio/dio.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../../const.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<void> makePayment() async {
    try {
      String? paymentIntentClientSecrets =
          await _createPaymentIntent(200, 'usd');
      if (paymentIntentClientSecrets == null) return;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecrets,
          merchantDisplayName: 'Zuraiz Khan',
        ),
      );
      await _processPayment();
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

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
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
