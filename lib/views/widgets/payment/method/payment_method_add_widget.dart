import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PaymentMethodAddWidget extends StatelessWidget {

  final Function onSelected;

  PaymentMethodAddWidget({this.onSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            height: 45.0,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(Get.context).primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            child: Center(
                child: Text('+ 간편 결제수단 추가', style: TextStyle(color: Theme.of(Get.context).primaryColor, fontSize: 14.0, fontWeight: FontWeight.w600))
            )
          ),
        ),
      ),
    );
  }
}
