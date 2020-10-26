import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DeliveryDetailBottomBar extends StatelessWidget {

  final String centerText;
  final bool isActive;
  final Function onSelected;
  final bool isVisible;

  DeliveryDetailBottomBar({this.centerText, this.isActive = true, this.onSelected, this.isVisible = true});

  @override
  Widget build(BuildContext context) {
    if(isVisible) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: SafeArea(
          child: GestureDetector(
            onTap: isActive ? onSelected : () => {},
            child: Opacity(
              opacity: isActive ? 1.0 : 0.5,
              child: SizedBox(
                height: 65.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: Theme.of(Get.context).primaryColor,
                    child: Center(
                      child: Text('$centerText', style: TextStyle(color: Theme.of(Get.context).backgroundColor, fontWeight: FontWeight.bold, fontSize: 17.0)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
