import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OrderSubscribeInfoItemFooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      decoration: BoxDecoration(
          color: Theme.of(Get.context).primaryColor,
          border: Border.all(
              width: 0.5,
              color: Theme.of(Get.context).primaryColor
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          )
      ),
      child: Center(child: Text('정기배송 관리', style: TextStyle(color: Theme.of(Get.context).backgroundColor, fontWeight: FontWeight.bold))),
    );
  }
}
