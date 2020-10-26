import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderInfoDetailBottomBtnWidget extends StatelessWidget {

  final bool isActive;
  final Function onTap;
  final String title;

  OrderInfoDetailBottomBtnWidget({this.isActive = true, this.onTap, this.title = '확인'});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        child: Opacity(
          opacity: isActive ? 1.0 : 0.5,
          child: SizedBox(
            height: 65.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: isActive ? Theme.of(Get.context).primaryColor : Colors.grey,
                child: Center(
                  child: Text('$title', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17.0)
                  ),
                ),
              ),
            ),
          ),
        ),
        onTap: isActive
          ? onTap
          : (){},
      ),
    );
  }
}
