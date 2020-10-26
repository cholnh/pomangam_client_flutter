import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/domains/order/order_response.dart';
import 'package:pomangam_client_flutter/domains/order/order_type.dart';

class OrderInfoCurrentItemFooterWidget extends StatelessWidget {

  final OrderResponse order;
  final Color selectedColor = Theme.of(Get.context).primaryColor;
  final Color unSelectedColor = Colors.black.withOpacity(0.3);

  OrderInfoCurrentItemFooterWidget({this.order});

  int _step() {
    int step = 0;
    switch(order.orderType) {
      case OrderType.PAYMENT_READY_FAIL_POINT:
      case OrderType.PAYMENT_READY_FAIL_COUPON:
      case OrderType.PAYMENT_READY_FAIL_PROMOTION:
      case OrderType.PAYMENT_FAIL:
        step = -1; break;
      case OrderType.PAYMENT_READY:
        step = 6; break;
      case OrderType.PAYMENT_SUCCESS:
      case OrderType.ORDER_READY:
      case OrderType.ORDER_QUICK_READY:
        step = 0; break;
      case OrderType.DELIVERY_READY:
        step = 1; break;
      case OrderType.DELIVERY_PICKUP:
      case OrderType.DELIVERY_DELAY:
        step = 2; break;
      case OrderType.DELIVERY_SUCCESS:
        step = 3; break;
      case OrderType.PAYMENT_CANCEL:
      case OrderType.PAYMENT_REFUND:
      case OrderType.ORDER_REFUSE:
      case OrderType.ORDER_CANCEL:
        step = 4; break;
      case OrderType.MISS_BY_DELIVERER:
      case OrderType.MISS_BY_STORE:
        step = 5; break;
    }
    return step;
  }

  @override
  Widget build(BuildContext context) {
    int step = _step();

    if(step == 3) {
      if(isValidDate(order.orderDate)) {
        return Container(
          height: 40.0,
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
          child: Center(
            child: Text('리뷰쓰기', style: TextStyle(
              color: Theme.of(Get.context).backgroundColor,
              fontWeight: FontWeight.bold
            ))
          ),
        );
      } else {
        return Container(
          height: 40.0,
          decoration: BoxDecoration(
              color: unSelectedColor,
              border: Border.all(
                  width: 0.5,
                  color: unSelectedColor
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              )
          ),
          child: Center(
              child: Text('리뷰쓰기 (기간만료)', style: TextStyle(
                  color: Theme.of(Get.context).backgroundColor,
                  fontWeight: FontWeight.bold
              ))
          ),
        );
      }
    }

    return Column(
      children: [
        Divider(color: Theme.of(context).textTheme.subtitle2.color, thickness: 0.5),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
          child: _stepWidget(step),
        ),
      ],
    );
  }

  bool isValidDate(DateTime dt) {
    DateTime now = DateTime.now();
    DateTime d = dt.add(Duration(days: 2));
    return d.isAfter(now);
  }

  Widget _stepWidget(int step) {
//    if(step == -1) {
//      return Row(
//        mainAxisAlignment: MainAxisAlignment.start,
//        children: [
//          Container(
//              padding: const EdgeInsets.all(6.0),
//              decoration: BoxDecoration(
//                color: unSelectedColor,
//                borderRadius: BorderRadius.all(
//                    Radius.circular(20.0)
//                ),
//              ),
//              child: Text('주문실패', style: TextStyle(fontSize: 13.0, color: Theme.of(Get.context).backgroundColor))
//          ),
//        ],
//      );
//    }
    if(step == 4) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: unSelectedColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(20.0)
                ),
              ),
              child: Text('주문취소', style: TextStyle(fontSize: 13.0, color: Theme.of(Get.context).backgroundColor))
          ),
        ],
      );
    }
    if(step == 5) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: unSelectedColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(20.0)
                ),
              ),
              child: Text('주문누락', style: TextStyle(fontSize: 13.0, color: Theme.of(Get.context).backgroundColor))
          ),
        ],
      );
    }
    if(step == 6) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: selectedColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(20.0)
                ),
              ),
              child: Text('결제대기', style: TextStyle(fontSize: 13.0, color: Theme.of(Get.context).backgroundColor))
          ),
        ],
      );
    }
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          /// step 0
          Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: step == 0 ? selectedColor : unSelectedColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(20.0)
                ),
              ),
              child: Text('주문대기', style: TextStyle(fontSize: 13.0, color: Theme.of(Get.context).backgroundColor))
          ),
          Icon(Icons.arrow_right, color: step == 0 ? selectedColor : unSelectedColor),

          /// step 1
          Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: step == 1 ? selectedColor : unSelectedColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(20.0)
                ),
              ),
              child: Text('메뉴준비', style: TextStyle(fontSize: 13.0, color: Theme.of(Get.context).backgroundColor))
          ),
          Icon(Icons.arrow_right, color: step == 1 ? selectedColor : unSelectedColor),

          /// step 2
          Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: step == 2 ? selectedColor : unSelectedColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(20.0)
                ),
              ),
              child: Text('배달중', style: TextStyle(fontSize: 13.0, color: Theme.of(Get.context).backgroundColor))
          ),
          Icon(Icons.arrow_right, color: step == 2 ? selectedColor : unSelectedColor),

          /// step 3
          Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: step == 3 ? selectedColor : unSelectedColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(20.0)
                ),
              ),
              child: Text('배달완료', style: TextStyle(fontSize: 13.0, color: Theme.of(Get.context).backgroundColor))
          ),

          SizedBox(width: 15)
        ],
      ),
    );
  }
}
