import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/_bases/util/toast_utils.dart';
import 'package:pomangam_client_flutter/domains/order/order_response.dart';
import 'package:pomangam_client_flutter/domains/order/order_type.dart';
import 'package:pomangam_client_flutter/domains/payment/payment_type.dart';

class OrderInfoDetailInfoWidget extends StatelessWidget {

  final OrderResponse order;

  OrderInfoDetailInfoWidget({this.order});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text('주문정보', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.headline1.color
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_type(), style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _typeColor()
                  )),
                  // SizedBox(width: 5),
                  // Container(
                  //   padding: const EdgeInsets.all(3),
                  //   decoration: BoxDecoration(
                  //     color: Colors.transparent,
                  //     shape: BoxShape.circle,
                  //     border: Border.all(
                  //       color: Theme.of(context).textTheme.subtitle2.color,
                  //       width: 1
                  //     )
                  //   ),
                  //   child: Text('?', style: TextStyle(
                  //     color: Theme.of(context).textTheme.subtitle2.color,
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 10
                  //   )),
                  // )
                ],
              )
            ],
          ),
          SizedBox(height: 15),
          Divider(thickness: 0.5, height: kIsWeb ? 1.0 : 0.5, color: Colors.black),
          SizedBox(height: 15),
          _text(
            leftText: '주문번호',
            rightText: 'no.${order.idx}'
          ),
          SizedBox(height: 15),
          _text(
            leftText: '식별번호',
            rightText: '${order.boxNumber}번'
          ),
          SizedBox(height: 15),
          _text(
            leftText: '승인일시',
            rightText: '${_date(order.registerDate)}'
          ),
          SizedBox(height: 15),
          _text(
            leftText: '결제수단',
            rightText: '${convertPaymentTypeToText(order.paymentType)}',
          ),
          SizedBox(height: 15),
          _text(
            leftText: '받는장소',
            rightText: '${order.nameDeliverySite} ${order.nameDeliveryDetailSite}'
          ),
          SizedBox(height: 15),
          _text(
              leftText: '받는시간',
              rightText: '${_textDate(order.orderDate)} ${_textTime(order)}'
          ),
          SizedBox(height: 15),
          if(order.paymentType == PaymentType.COMMON_V_BANK && order.orderType == OrderType.PAYMENT_READY) Column(
            children: [
              Divider(thickness: 0.5, height: kIsWeb ? 1.0 : 0.5),
              SizedBox(height: 15),
              _text(
                  leftText: '입금은행',
                  rightText: '${Endpoint.vbank}'
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 80,
                    child: Text('계좌번호', style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(Get.context).textTheme.subtitle2.color
                    ), maxLines: 2, overflow: TextOverflow.ellipsis),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${Endpoint.vbankAccount}', style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(Get.context).textTheme.headline1.color
                        )),
                        GestureDetector(
                          onTap: _copy,
                          child: Material(
                            color: Colors.transparent,
                            child: Text('복사하기', style: TextStyle(
                                fontSize: 11,
                                color: Theme.of(Get.context).primaryColor
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              _text(
                  leftText: '입금금액',
                  rightText: '${StringUtils.comma(order.paymentCost)}원'
              ),
              SizedBox(height: 15),
            ],
          )
        ],
      ),
    );
  }

  void _copy() {
    Clipboard.setData(new ClipboardData(text: '${Endpoint.vbank} ${Endpoint.vbankAccount}'));
    ToastUtils.showToast(msg: "복사완료");
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

  String _date(DateTime dt) {
    return DateFormat('yyyy/MM/dd hh:mm:ss').format(dt);
  }

  String _type() {
    String nameType = '';
    switch(order.orderType) {
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

  Color _typeColor() {
    Color color = Theme.of(Get.context).textTheme.headline1.color;
    switch(order.orderType) {
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

  Widget _text({
    String leftText = '',
    String rightText = '',
    Color color
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(leftText, style: TextStyle(
              fontSize: 14,
              color: color == null ? Theme.of(Get.context).textTheme.subtitle2.color : color
          ), maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
        Expanded(
          child: Text(rightText, style: TextStyle(
              fontSize: 14,
              color: color == null ? Theme.of(Get.context).textTheme.headline1.color : color
          )),
        ),
      ],
    );
  }

}
