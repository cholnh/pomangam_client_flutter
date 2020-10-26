import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OrderSubscribeInfoItemHeaderWidget extends StatelessWidget {

  final String title;

  OrderSubscribeInfoItemHeaderWidget({this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Theme.of(Get.context).primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0)
              ),
            ),
            child: Text(title, style: TextStyle(fontSize: 13.0, color: Theme.of(Get.context).backgroundColor))
          )
        ],
      ),
    );
  }
}
