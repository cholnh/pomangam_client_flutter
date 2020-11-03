import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/domains/order/item/order_item_response.dart';
import 'package:pomangam_client_flutter/domains/order/order_response.dart';

class OrderInfoDetailItemsWidget extends StatelessWidget {

  final OrderResponse order;

  OrderInfoDetailItemsWidget({this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('주문서', style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.headline1.color
          )),
          SizedBox(height: 15),
          Divider(thickness: 0.5, height: kIsWeb ? 1.0 : 0.5, color: Colors.black),
          SizedBox(height: 10),
          _text(
            leftText: '메뉴명',
            centerText: '수량',
            rightText: '금액',
            color: Theme.of(Get.context).textTheme.subtitle2.color
          ),
          SizedBox(height: 10),
          Divider(thickness: 0.5, height: kIsWeb ? 1.0 : 0.5, color: Colors.black),
          SizedBox(height: 15),
          _items(),
          _text(
              leftText: '주문금액',
              rightText: '${StringUtils.comma(order.totalCost)}원'
          ),
          SizedBox(height: 15),
          _text(
              leftText: '배달비',
              rightText: '+0원'
          ),
          SizedBox(height: 15),
          _text(
              leftText: '할인금액',
              rightText: '-${StringUtils.comma(order.discountCost)}원',
          ),
          SizedBox(height: 15),
          Divider(thickness: 0.5, height: kIsWeb ? 1.0 : 0.5, color: Colors.black),
          SizedBox(height: 15),
          _text(
              leftText: '합계',
              rightText: '${StringUtils.comma(order.paymentCost)}원',
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _text({
    String leftText = '',
    String centerText = '',
    String rightText = '',
    Color color
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(leftText, style: TextStyle(
            fontSize: 14,
            color: color == null ? Theme.of(Get.context).textTheme.headline1.color : color
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(centerText, style: TextStyle(
                fontSize: 14,
                color: color == null ? Theme.of(Get.context).textTheme.headline1.color : color
            )),
            SizedBox(width: 40),
            Text(rightText, style: TextStyle(
                fontSize: 14,
                color: color == null ? Theme.of(Get.context).textTheme.headline1.color : color
            )),
          ],
        ),
      ],
    );
  }

  Widget _items() {
    List<Widget> widgets = [];
    Set<String> nameStores = order.orderItems.map((item) => item.nameStore).toSet();
    for(String nameStore in nameStores) {
      List<OrderItemResponse> orderItems = order.orderItems.where((item) => item.nameStore == nameStore).toList();
      widgets.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(Get.context).textTheme.subtitle2.color,
                width: 0.5
              )
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
            child: Text(nameStore, style: TextStyle(
              fontSize: 12,
              color: Theme.of(Get.context).textTheme.subtitle2.color
            )),
          ),
          SizedBox(height: 10),
          Column(
            children: orderItems.map((OrderItemResponse item) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.nameProduct, style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(Get.context).textTheme.headline1.color
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(item.quantity.toString(), style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(Get.context).textTheme.headline1.color
                          )),
                          SizedBox(width: 40),
                          Text('${StringUtils.comma(item.saleCost)}', style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(Get.context).textTheme.headline1.color
                          )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  _subs(item),
                ],
              );
            }).toList(),
          ),
          Divider(height: 0.5, thickness: kIsWeb ? 1.0 : 0.5, color: Colors.black),
          SizedBox(height: 15),
        ],
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets
    );
  }

  Widget _subs(OrderItemResponse item) {
    if(item.orderItemSubs.isEmpty && (item.requirement == null || item.requirement.isEmpty)) {
      return SizedBox(height: 5);
    }

    List<Widget> widgets = item.orderItemSubs.map((sub) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(' - ${sub.nameProductSub} ${sub.quantity}개', style: TextStyle(fontSize: 12.0, color: Theme.of(Get.context).textTheme.subtitle2.color)),
      );
    }).toList();
    if(item.requirement != null && item.requirement.isNotEmpty) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(' - ${item.requirement}', style: TextStyle(fontSize: 12.0, color: Theme.of(Get.context).textTheme.subtitle2.color)),
      ));
    }
    widgets.add(Padding(padding: const EdgeInsets.only(bottom: 5)));
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets
    );
  }
}
