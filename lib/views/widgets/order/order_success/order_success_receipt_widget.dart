import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/domains/order/item/order_item_response.dart';
import 'package:pomangam_client_flutter/domains/order/item/sub/order_item_sub_response.dart';
import 'package:pomangam_client_flutter/domains/order/order_response.dart';
import 'package:pomangam_client_flutter/domains/payment/payment_type.dart';

class OrderSuccessReceiptWidget extends StatelessWidget {

  final OrderResponse response;

  OrderSuccessReceiptWidget({this.response});

  @override
  Widget build(BuildContext context) {
    double fontSize = 13;
    return Container(
      width: 300,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.clear, color: Colors.transparent),
                Text('영수증', style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(Get.context).textTheme.headline1.color,
                )),
                GestureDetector(
                  onTap: () {
                    if(Navigator.of(Get.overlayContext).canPop()) {
                      Navigator.of(Get.overlayContext).pop();
                    }
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: Icon(Icons.clear, size: 20)
                  )
                ),
              ],
            ),
            SizedBox(height: 15),
            Divider(height: 2.5, thickness: 1.0, color: Colors.grey[200]),
            Divider(height: 2.5, thickness: 1.0, color: Colors.grey[200]),
            SizedBox(height: 15),
            _text(
                left: '주문번호',
                right: 'no.${response.idx}',
                fontSize: fontSize,
                rightFontWeight: FontWeight.normal
            ),
            SizedBox(height: 15),
            _text(
                left: '식별번호',
                right: '${response.boxNumber}번',
                fontSize: fontSize,
                leftFontWeight: FontWeight.bold,
                rightFontWeight: FontWeight.bold
            ),
            SizedBox(height: 15),
            _text(
                left: '승인일시',
                right: '${_date(response.registerDate)}',
                fontSize: fontSize,
                rightFontWeight: FontWeight.normal
            ),
            SizedBox(height: 15),
            _text(
                left: '결제수단',
                right: '${convertPaymentTypeToText(response.paymentType)}',
                fontSize: fontSize,
                rightFontWeight: FontWeight.normal
            ),
            SizedBox(height: 15),
            Divider(height: 2.5, thickness: 1.0, color: Colors.grey[200]),
            SizedBox(height: 15),
            for(OrderItemResponse item in response.orderItems)
              Column(
                children: [
                  _text(
                      left: item.nameProduct,
                      right: '${StringUtils.comma(item.saleCost)}원',
                      fontSize: fontSize,
                      rightFontWeight: FontWeight.normal
                  ),
                  SizedBox(height: item.orderItemSubs.isEmpty ? 15 : 10),
                  for(OrderItemSubResponse sub in item.orderItemSubs)
                    Column(
                      children: [
                        _text(
                            left: '  >  ' + sub.nameProductSub,
                            right: sub.saleCost == null || sub.saleCost == 0
                              ? ''
                              : '${StringUtils.comma(sub.saleCost)}원',
                            fontSize: 12,
                            rightFontWeight: FontWeight.normal,
                            color: Theme.of(Get.context).textTheme.subtitle2.color
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  if(item.requirement != null && item.requirement.isNotEmpty)
                    Column(
                      children: [
                        _text(
                            left: '  >  ' + item.requirement,
                            right: '',
                            fontSize: 12,
                            rightFontWeight: FontWeight.normal,
                            color: Theme.of(Get.context).textTheme.subtitle2.color
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  SizedBox(height: (item.requirement != null && item.requirement.isNotEmpty) || item.orderItemSubs.isNotEmpty ? 5 : 0),
                ],
              ),
            Divider(height: 2.5, thickness: 1.0, color: Colors.grey[200]),
            SizedBox(height: 15),
            _text(
                left: '주문금액',
                right: '${StringUtils.comma(response.totalCost)}원',
                fontSize: fontSize,
                rightFontWeight: FontWeight.normal
            ),
            SizedBox(height: 15),
            _text(
                left: '배달비',
                right: '+0원',
                fontSize: fontSize,
                rightFontWeight: FontWeight.normal
            ),
            SizedBox(height: 15),
            _text(
                left: '할인금액',
                right:  '-${StringUtils.comma(response.discountCost)}원',
                fontSize: fontSize,
                rightFontWeight: FontWeight.normal
            ),
            SizedBox(height: 15),
            Divider(height: 2.5, thickness: 1.0, color: Colors.grey[200]),
            SizedBox(height: 15),
            _text(
                left: '합계',
                right: '${StringUtils.comma(response.paymentCost)}원',
                fontSize: 14,
                leftFontWeight: FontWeight.bold
            ),
          ],
        ),
      ),
    );
  }

  Widget _text({
    String left,
    String right,
    double fontSize = 15,
    FontWeight leftFontWeight = FontWeight.normal,
    FontWeight rightFontWeight = FontWeight.bold,
    Color color
  }) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left, style: TextStyle(
              fontSize: fontSize,
              color: color == null ? Theme.of(Get.context).textTheme.headline1.color : color,
              fontWeight: leftFontWeight
          )),
          Text(right, style: TextStyle(
              fontSize: fontSize,
              color: color == null ? Theme.of(Get.context).textTheme.headline1.color : color,
              fontWeight: rightFontWeight
          ))
        ]
    );
  }

  String _date(DateTime dt) {
    return DateFormat('yyyy. MM. dd hh:mm:ss').format(dt);
  }
}
