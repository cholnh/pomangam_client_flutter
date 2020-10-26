import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/domains/coupon/coupon.dart';
import 'package:pomangam_client_flutter/domains/order/item/order_item_response.dart';
import 'package:pomangam_client_flutter/domains/order/item/sub/order_item_sub_response.dart';
import 'package:pomangam_client_flutter/domains/order/order_response.dart';

class OrderInfoCurrentItemBodyListItemWidget extends StatelessWidget {

  final OrderResponse order;

  OrderInfoCurrentItemBodyListItemWidget({this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _items(order.orderItems),
            Divider(height: 20.0, thickness: 0.5),
            _totalCost(order.totalCost, isActive: order.usingPoint != 0 || order.usingCoupons.isNotEmpty),
            _point(order.usingPoint),
            _coupon(order.usingCoupons),
            if(order.usingPoint != 0 || order.usingCoupons.isNotEmpty)
              Divider(height: 20.0, thickness: 0.5),
            _paymentCost(order.paymentCost)
          ],
        ),
      ],
    );
  }

  Widget _totalCost(int totalCost, {bool isActive = true}) {
    return isActive ? Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('주문금액', style: TextStyle(fontSize: 13.0, color: Theme.of(Get.context).textTheme.headline1.color)),
          Text('${StringUtils.comma(totalCost)}원', style: TextStyle(fontSize: 13.0, color: Theme.of(Get.context).textTheme.headline1.color)),
        ],
      ),
    ) : Container();
  }

  Widget _point(int point) {
    if(point <= 0) return Container();
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('포인트', style: TextStyle(fontSize: 13.0, color: Theme.of(Get.context).textTheme.headline1.color)),
          Text('- ${StringUtils.comma(point)}원', style: TextStyle(fontSize: 13.0, color: Theme.of(Get.context).textTheme.headline1.color)),
        ],
      ),
    );
  }

  Widget _coupon(List<Coupon> coupons) {
    return Column(
        children: coupons.map((coupon) => Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('${coupon.title}', style: TextStyle(fontSize: 13.0, color: Theme.of(Get.context).textTheme.headline1.color)),
              Text('- ${StringUtils.comma(coupon.discountCost)}원', style: TextStyle(fontSize: 13.0, color: Theme.of(Get.context).textTheme.headline1.color)),
            ],
          ),
        )).toList()
    );
  }

  Widget _paymentCost(int paymentCost) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('합계', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold)),
        Text('${StringUtils.comma(paymentCost)}원', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _items(List<OrderItemResponse> items) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Text('${item.nameProduct} ${item.quantity}개', style: TextStyle(
                        fontSize: 14.0,
                        color: Theme.of(Get.context).textTheme.headline1.color
                    ), maxLines: 2, overflow: TextOverflow.ellipsis
                    )),
                SizedBox(width: 10),
                Text('${StringUtils.comma(item.saleCost)}원', style: TextStyle(fontSize: 13.0)),
              ],
            ),
            Padding(padding: const EdgeInsets.only(bottom: 5.0)),
            _subItems(item.orderItemSubs),
            if(item.requirement != null && item.requirement.isNotEmpty)
              Text(' - ${item.requirement}', style: TextStyle(
                  fontSize: 13.0,
                  color: Theme.of(Get.context).textTheme.subtitle2.color
              )),
            Padding(padding: const EdgeInsets.only(bottom: 10.0)),
          ],
        )).toList()
    );
  }

  Widget _subItems(List<OrderItemSubResponse> subItems) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: subItems.map((subItem) => Text(' - ${subItem.nameProductSub} ${subItem.quantity}개', style: TextStyle(
            fontSize: 13.0,
            color: Theme.of(Get.context).textTheme.subtitle2.color
        ))).toList()
    );
  }
}
