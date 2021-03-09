import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/domains/cart/cart.dart';
import 'package:pomangam_client_flutter/domains/payment/payment.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/views/pages/payment/method/payment_phone_number_page.dart';
import 'package:pomangam_client_flutter/views/pages/payment/payment_page.dart';
import 'package:pomangam_client_flutter/views/pages/payment/payment_page_type.dart';
import 'package:pomangam_client_flutter/domains/payment/payment_type.dart';
import 'package:pomangam_client_flutter/providers/cart/cart_model.dart';
import 'package:pomangam_client_flutter/providers/payment/payment_model.dart';
import 'package:provider/provider.dart';

class CartFooterWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    bool isSignIn = context.watch<SignInModel>().isSignIn();

    Cart cart = context.watch<CartModel>().cart;
    Payment payment = context.watch<PaymentModel>().payment;
    PaymentType paymentType = payment?.paymentType;

    bool isViewCoupon = cart.getAllUsingCoupons().length > 0;
    bool isViewPoint = cart.usingPoint > 0;

    return Column(
      children: <Widget>[
        Divider(height: 40.0, thickness: 3.0, color: Colors.grey[100]),
        Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _navigateToPayment(context),
                  child: Material(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            convertPaymentTypeToIcon(paymentType),
                            SizedBox(width: 10),
                            Text('${convertPaymentTypeToText(paymentType)}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Theme.of(context).textTheme.headline1.color)),
                            Text('${_vbankText(paymentType)}', style: TextStyle(fontSize: 13.0, color: Theme.of(context).textTheme.headline1.color))
                          ],
                        ),
                        Text(paymentType == null ? '등록하기' : '변경', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: 13.0))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),

                if(!isSignIn) GestureDetector(
                  onTap: () => _navigateToPaymentPhoneNumber(context),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Icon(Icons.chevron_right, size: 14.0),
                          Padding(padding: EdgeInsets.only(right: 10.0)),
                          Text(payment.phoneNumber.isNullOrBlank ? '비회원 핸드폰번호 미등록' : '비회원 정보 : ${payment.phoneNumber}',
                              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Theme.of(context).textTheme.headline1.color))
                        ],
                      ),
                    ],
                  ),
                ),
                if(!isSignIn) SizedBox(height: 15),

                if (isViewCoupon) Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Icon(Icons.chevron_right, size: 14.0),
                        Padding(padding: EdgeInsets.only(right: 10.0)),
                        Text('쿠폰 ${StringUtils.comma(cart.discountPriceUsingCoupons())}원 사용',
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Theme.of(context).textTheme.headline1.color))
                      ],
                    ),
                  ],
                ),
                if (isViewPoint) Column(
                  children: [
                    if(isViewCoupon) SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Icon(Icons.chevron_right, size: 14.0),
                        Padding(padding: EdgeInsets.only(right: 10.0)),
                        Text('포인트 ${StringUtils.comma(cart.usingPoint)}원 사용',
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Theme.of(context).textTheme.headline1.color))
                      ],
                    ),
                  ],
                ),
                if (isViewCoupon || isViewPoint) SizedBox(height: 15)
              ],
            )
        ),
      ],
    );
  }
  void _navigateToPaymentPhoneNumber(BuildContext context) {
    context.read<PaymentModel>().pageType = PaymentPageType.FROM_PAYMENT;
    Get.to(PaymentPhoneNumberPage(), duration: Duration.zero);
  }
  void _navigateToPayment(BuildContext context) {
    context.read<PaymentModel>().pageType = PaymentPageType.FROM_PAYMENT;
    Get.to(PaymentPage(), duration: Duration.zero);
  }
  String _vbankText(PaymentType paymentType) {
    if(paymentType == PaymentType.COMMON_V_BANK) {
      String vn = Get.context.read<PaymentModel>().payment.vbankName;
      return vn.isNullOrBlank ? ' (입금자 미설정)' : ' (입금자명 $vn)';
    }
    return '';
  }
}
