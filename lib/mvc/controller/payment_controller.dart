import 'dart:convert';

import 'package:elm/mvc/controller/error_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sumup/sumup.dart';
import '../../service/api/api_client.dart';
import '../../utils/utils.dart';

class PaymentController extends GetxController with ErrorController {
  /// Post amount
  void makePayment(int? id, String userEmail,
      String homeAddress, int? targetAmount,
      {required String name, required int amount}) async {
    Utils.showLoading();
    var body = jsonEncode({
      "project_id": id,
      "name": name,
      "email": userEmail,
      "address": homeAddress,
      "target_amount": targetAmount,
      "amount": amount,
    });
    var response = await ApiClient()
        .post('/api/payment', body, header: Utils.apiHeader)
        .catchError(handleApiError);
    print(response);
    print("payment done");
  }

  ///SUMUP card machine payment

  Future<void> startSumUpPayment(double amount, String currency) async {
    try {
      var payment = SumupPayment(
        title: 'Test payment',
        total: amount,
        currency: currency,
        foreignTransactionId: '',
        saleItemsCount: 0,
        skipSuccessScreen: false,
        skipFailureScreen: true,
        tip: .0,
        customerEmail: null,
        customerPhone: null,
      );
      var request = SumupPaymentRequest(payment);
      var checkout = await Sumup.checkout(request);
      print(checkout);
    } on PlatformException catch (e) {
      print('Error starting SumUp payment: ${e.message}');
    }
  }
}
