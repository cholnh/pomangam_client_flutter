import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/domains/payment/payment.dart';
import 'package:pomangam_client_flutter/views/pages/payment/payment_page_type.dart';

class PaymentModel with ChangeNotifier {

  /// model
  Payment payment = Payment();

  /// data
  PaymentPageType pageType = PaymentPageType.FROM_SETTING;

  /// notifyListeners
  void notify() {
    notifyListeners();
  }
}