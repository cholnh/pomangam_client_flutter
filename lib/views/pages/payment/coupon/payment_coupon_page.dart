import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomangam_client_flutter/providers/coupon/coupon_model.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/payment/coupon/payment_coupon_add_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/payment/coupon/payment_coupon_list_widget.dart';

class PaymentCouponPage extends StatefulWidget {
  @override
  _PaymentCouponPageState createState() => _PaymentCouponPageState();
}

class _PaymentCouponPageState extends State<PaymentCouponPage> {

  bool isSignIn = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {

    isSignIn = await Provider.of<SignInModel>(context, listen: false).isSignIn();
    if(isSignIn) {
      Provider.of<CouponModel>(context, listen: false)
      ..clear()
      ..fetchAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: '할인쿠폰',
        leadingIcon: const Icon(CupertinoIcons.back, size: 20, color: Colors.black),
        elevation: 1.0,
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            PaymentCouponAddWidget(isSignIn: isSignIn),
            PaymentCouponListWidget(isSignIn: isSignIn)
          ],
        ),
      )
    );
  }
}