import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/domains/order/order_response.dart';

class OrderInfoCurrentItemHeaderWidget extends StatelessWidget {

  final OrderResponse order;

  OrderInfoCurrentItemHeaderWidget({this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('식별번호:', style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(Get.context).textTheme.headline1.color
              )),
              Text(' ${order.boxNumber}번', style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(Get.context).textTheme.headline1.color
              )),
            ],
          ),
          Icon(Icons.more_horiz, size: 20)
        ],
      ),
    );
  }
}
