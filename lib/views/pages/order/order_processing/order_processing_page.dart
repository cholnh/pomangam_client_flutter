import 'package:flutter/material.dart';
import 'package:flutter_animation_set/animation_set.dart';
import 'package:flutter_animation_set/animator.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/providers/order/order_model.dart';
import 'package:pomangam_client_flutter/views/pages/order/order_fail/order_fail_page.dart';
import 'package:pomangam_client_flutter/views/pages/order/order_success/order_success_page.dart';
import 'package:pomangam_client_flutter/views/pages/order/order_success/order_vbank_success_page.dart';
import 'package:provider/provider.dart';

class OrderProcessingPage extends StatefulWidget {

  @override
  _OrderProcessingPageState createState() => _OrderProcessingPageState();
}

class _OrderProcessingPageState extends State<OrderProcessingPage> {

  @override
  void initState() {
    OrderModel orderModel = context.read();
    Future.delayed(Duration(seconds: 10), () {
      if(orderModel != null && orderModel.isVerifying) {
        orderModel.clear();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OrderModel orderModel = context.watch();
    if(orderModel.isVerifying) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        makeLine(0),
                        makeLine(50),
                        makeLine(100),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Text('결제 진행 중입니다.', style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  )),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      if(orderModel.status == 2) {
        return OrderVBankSuccessPage();
      }
      return orderModel.isValidOrder
        ? OrderSuccessPage()
        : OrderFailPage(reason: '주문정보와 PG결제정보가 일치하지 않습니다.');
    }
  }

  Widget makeLine(int delay) {
    return AnimatorSet(
      child: Container(
        color: Theme.of(Get.context).primaryColor,
        width: 10,
        height: 5,
      ),
      animatorSet: [
        TY(from: 0.0, to: 5.0, duration: 400, delay: delay, curve: Curves.fastOutSlowIn,),
        TY(from: 5.0, to: 0.0, duration: 400, curve: Curves.fastOutSlowIn,),
      ],
    );
  }
}
