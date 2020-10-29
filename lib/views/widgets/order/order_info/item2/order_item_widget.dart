import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/domains/order/item/order_item_response.dart';
import 'package:pomangam_client_flutter/domains/order/order_response.dart';
import 'package:pomangam_client_flutter/domains/order/order_type.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/views/pages/deliverysite/detail/delivery_detail_page_type.dart';
import 'package:pomangam_client_flutter/views/pages/deliverysite/detail/delivery_detail_site_page.dart';
import 'package:pomangam_client_flutter/views/pages/order/order_info/order_info_detail_page.dart';
import 'package:pomangam_client_flutter/views/pages/order/order_info/order_info_page_type.dart';
import 'package:pomangam_client_flutter/views/pages/store/review/store_review_select_page.dart';
import 'package:pomangam_client_flutter/views/pages/store/review/store_review_write_page.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_divider.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/sign_modal.dart';
import 'package:provider/provider.dart';

class OrderItemWidget extends StatelessWidget {

  final OrderResponse order;
  final OrderInfoPageType pageType;

  OrderItemWidget({this.order, this.pageType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _onTap,
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Text('${order.boxNumber}번', style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold
                          )),
                          SizedBox(width: 10),
                          Text(
                            '${_textDate(order.orderDate)} ${_textTime(order)}' + (isPastDay(order.orderDate) ? '' : ' 도착 예정'),
                            style: TextStyle(fontSize: 13, color: Theme.of(context).textTheme.subtitle2.color)
                          ),
                        ],
                      ),
                    ),
                    Text('${_type(order.orderType)}', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _typeColor(order.orderType),
                      fontSize: 13.0
                    ))
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: _isDone() ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${order.nameDeliverySite} ${order.nameDeliveryDetailSite}', style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ), overflow: TextOverflow.ellipsis, maxLines: 3),
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            Text('${StringUtils.ellipsis(order.orderItems.first.nameProduct, limit: 20)}', style: TextStyle(
                                fontSize: 15.0,
                                color: Theme.of(Get.context).textTheme.headline1.color
                            )),
                            if(order.orderItems.length != 1)
                              Text(' 외 ${order.orderItems.length-1}개', style: TextStyle(
                                  fontSize: 15.0,
                                  color: Theme.of(Get.context).textTheme.headline1.color
                              ))
                            else Text(' ${order.orderItems.first.quantity}개', style: TextStyle(
                                fontSize: 15.0,
                                color: Theme.of(Get.context).textTheme.headline1.color
                            )),
                            Text(' ${StringUtils.comma(order.paymentCost)}원', style: TextStyle(
                                fontSize: 15.0,
                                color: Theme.of(Get.context).textTheme.headline1.color
                            ))
                          ],
                        )
                      ],
                    ),
                    if(_isValidChange()) GestureDetector(
                      onTap: _change,
                      child: Material(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                          child: Text('변경', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: 13.0)),
                        )
                      )
                    ) else if(_isDone()) GestureDetector(
                      onTap: _signGuide,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.5
                          ),
                          borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              Icon(Icons.mode_edit, size: 16, color: Colors.black),
                              SizedBox(width: 3),
                              Text('리뷰쓰기', style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0
                              )),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        CustomDivider()
      ],
    );
  }

  void _onTap() {
    Get.to(OrderInfoDetailPage(order: order),
        transition: Transition.cupertino,
        duration: Duration.zero
    );
  }

  void _signGuide() {
    // 로그인 유도
    if(Get.context.read<SignInModel>().isSignIn()) {
      _onReview();
    } else {
      showSignModal(predicateUrl: Get.currentRoute);
    }
  }

  void _onReview() {
    Set<int> idxItems = Set();
    Set<int> idxStores = Set();
    for(OrderItemResponse item in order.orderItems) {
      if(!item.reviewWrite) {
        idxStores.add(item.idxStore);
        idxItems.add(item.idx);
      }
    }
    if(idxStores.length > 1) {
      Get.to(StoreReviewSelectPage(order: order));
    } else {
      String nameProducts = '';
      for(int i=0; i<order.orderItems.length; i++) {
        OrderItemResponse item = order.orderItems[i];
        if(!item.reviewWrite) {
          nameProducts += '#${item.nameProduct}' + (i == order.orderItems.length - 1 ? '' : ' ');
        }
      }
      Get.to(StoreReviewWritePage(
        idxesOrderItem: idxItems.toList(),
        idxStore: idxStores.first,
        nameStore: order.orderItems.first.nameStore,
        nameProducts: nameProducts
      ));
    }
  }

  void _change() {
    Get.to(DeliveryDetailSitePage(Get.context.read<DeliverySiteModel>().userDeliverySite, oIdx: order.idx),
      arguments: DeliveryDetailPageType.FROM_ORDER_INFO,
      transition: Transition.cupertino,
      duration: Duration.zero
    );
  }

  bool _isValidChange() {
    return pageType == OrderInfoPageType.CURRENT &&
        order.orderType == OrderType.ORDER_READY ||
        order.orderType == OrderType.ORDER_QUICK_READY ||
        order.orderType == OrderType.ORDER_SUCCESS ||
        order.orderType == OrderType.DELIVERY_READY ||
        order.orderType == OrderType.DELIVERY_DELAY ||
        order.orderType == OrderType.DELIVERY_PICKUP ||
        order.orderType == OrderType.MISS_BY_DELIVERER ||
        order.orderType == OrderType.MISS_BY_STORE ||
        order.orderType == OrderType.RE_DELIVERY
    ;
  }

  bool _isDone() {
    DateTime dl = DateTime.now().subtract(Duration(days: 3));
    bool isDeadline = order.orderDate.year < dl.year ||
        order.orderDate.month < dl.month ||
        order.orderDate.day < dl.day;
    bool isAllWrote = true;
    for(OrderItemResponse item in order.orderItems) {
      if(!item.reviewWrite) {
        isAllWrote = false;
        break;
      }
    }
    return order.orderType == OrderType.DELIVERY_SUCCESS && !isDeadline && !isAllWrote;
  }

  String _textDate(DateTime dt) {
    String result = '';
    if(isSameDay(dt, DateTime.now())) {
      return '오늘';
    } else if(isSameDay(dt, DateTime.now().add(Duration(days: 1)))) {
      result = '내일 ';
    } else if(isSameDay(dt, DateTime.now().add(Duration(days: 2)))) {
      result = '모레 ';
    }
    String weekday;
    switch(dt.weekday) {
      case 1: weekday = '(월)'; break;
      case 2: weekday = '(화)'; break;
      case 3: weekday = '(수)'; break;
      case 4: weekday = '(목)'; break;
      case 5: weekday = '(금)'; break;
      case 6: weekday = '(토)'; break;
      case 7: weekday = '(일)'; break;
    }

    return result + DateFormat('MM/dd$weekday').format(dt);
  }

  String _textTime(OrderResponse order) {
    int h = int.tryParse(order.arrivalTime.split(':')[0]);
    int m = int.tryParse(order.arrivalTime.split(':')[1]);
    m += int.tryParse(order.additionalTime.split(':')[1]);
    if(m >= 60) {
      m -= 60;
      h += 1;
    }
    return '$h시' + (m == 0 ? '' : ' $m분');
  }

  bool isSameDay(DateTime day1, DateTime day2) {
    return day1.year == day2.year &&
        day1.month == day2.month &&
        day1.day == day2.day;
  }

  bool isPastDay(DateTime day) {
    DateTime now = DateTime.now();
    return day.year < now.year ||
        day.month < now.month ||
        day.day < now.day;
  }

  String _type(OrderType orderType) {
    String nameType = '';
    switch(orderType) {
      case OrderType.PAYMENT_READY_FAIL_POINT:
      case OrderType.PAYMENT_READY_FAIL_COUPON:
      case OrderType.PAYMENT_READY_FAIL_PROMOTION:
      case OrderType.PAYMENT_FAIL:
        nameType = '결제실패'; break;
      case OrderType.PAYMENT_READY:
        nameType = '결제대기'; break;
      case OrderType.PAYMENT_SUCCESS:
      case OrderType.ORDER_READY:
      case OrderType.ORDER_QUICK_READY:
        nameType = '주문대기'; break;
      case OrderType.DELIVERY_READY:
        nameType = '메뉴준비'; break;
      case OrderType.DELIVERY_PICKUP:
      case OrderType.DELIVERY_DELAY:
        nameType = '배달중'; break;
      case OrderType.DELIVERY_SUCCESS:
        nameType = '배달완료'; break;
      case OrderType.PAYMENT_CANCEL:
      case OrderType.PAYMENT_REFUND:
      case OrderType.ORDER_REFUSE:
      case OrderType.ORDER_CANCEL:
        nameType = '주문취소'; break;
      case OrderType.MISS_BY_DELIVERER:
      case OrderType.MISS_BY_STORE:
        nameType = '주문누락'; break;
      default:
        nameType = '알수없음'; break;
    }
    return nameType;
  }

  Color _typeColor(OrderType orderType) {
    Color color = Theme.of(Get.context).textTheme.headline1.color;
    switch(orderType) {
      case OrderType.PAYMENT_READY_FAIL_POINT:
      case OrderType.PAYMENT_READY_FAIL_COUPON:
      case OrderType.PAYMENT_READY_FAIL_PROMOTION:
      case OrderType.PAYMENT_FAIL:
        color = Theme.of(Get.context).textTheme.headline1.color; break;
      case OrderType.PAYMENT_READY:
      case OrderType.PAYMENT_SUCCESS:
      case OrderType.ORDER_READY:
      case OrderType.ORDER_QUICK_READY:
        color = Theme.of(Get.context).primaryColor; break;
      case OrderType.DELIVERY_READY:
        color = Theme.of(Get.context).primaryColor; break;
      case OrderType.DELIVERY_PICKUP:
      case OrderType.DELIVERY_DELAY:
        color = Theme.of(Get.context).primaryColor; break;
      case OrderType.DELIVERY_SUCCESS:
        color = Theme.of(Get.context).textTheme.headline1.color; break;
      case OrderType.PAYMENT_CANCEL:
      case OrderType.PAYMENT_REFUND:
      case OrderType.ORDER_REFUSE:
      case OrderType.ORDER_CANCEL:
        color = Theme.of(Get.context).textTheme.headline1.color; break;
      case OrderType.MISS_BY_DELIVERER:
      case OrderType.MISS_BY_STORE:
        color = Theme.of(Get.context).textTheme.headline1.color; break;
      default:
        color = Theme.of(Get.context).textTheme.headline1.color; break;
    }
    return color;
  }
}
