import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/util/log_utils.dart';
import 'package:pomangam_client_flutter/domains/payment/payment.dart';
import 'package:pomangam_client_flutter/domains/payment/payment_type.dart';
import 'package:pomangam_client_flutter/providers/payment/payment_model.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:provider/provider.dart';

Future<bool> paymentDataInitialize() async
=> logProcess(
    name: 'paymentDataInitialize',
    function: () async {
      PaymentModel paymentModel = Get.context.read<PaymentModel>();
      if(paymentModel.payment == null) {
        paymentModel.payment = Payment();
      }
      //(await SharedPreferences.getInstance()).remove('__payment_type__');
      await paymentModel.payment.loadPayment();
      if( !Get.context.read<SignInModel>().isSignIn() ) {
        if(paymentModel.payment.paymentType == PaymentType.CONTACT_CREDIT_CARD ||
            paymentModel.payment.paymentType == PaymentType.CONTACT_CASH) {
          paymentModel.payment.paymentType = null;
        }
      }
      return true;
    }
);