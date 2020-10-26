import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/domains/order/order_response.dart';
import 'package:pomangam_client_flutter/domains/order/order_type.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client_flutter/views/pages/deliverysite/detail/delivery_detail_page_type.dart';
import 'package:pomangam_client_flutter/views/pages/deliverysite/detail/delivery_detail_site_page.dart';
import 'package:pomangam_client_flutter/views/pages/order/order_info/order_info_page_type.dart';
import 'package:pomangam_client_flutter/views/widgets/order/order_info/item/order_info_current_item_body_list_item_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderInfoCurrentItemBodyWidget extends StatelessWidget {

  final OrderResponse order;
  final OrderInfoPageType pageType;

  OrderInfoCurrentItemBodyWidget({this.order, this.pageType});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text('${order.nameDeliverySite} ${order.nameDeliveryDetailSite}', style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ), overflow: TextOverflow.ellipsis, maxLines: 3),
                  ),
                  SizedBox(width: 10),
                  if(_isValidChange()) GestureDetector(
                    onTap: _change,
                    child: Material(
                      color: Colors.transparent,
                      child: Text('변경', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: 13.0))
                    )
                  )
                ],
              ),
              SizedBox(height: 5),
              Text(
                '${_textDate(order.orderDate)} ${_textTime(order)}' + (isPastDay(order.orderDate) ? '' : ' 도착 예정'),
                style: TextStyle(fontSize: 13, color: Theme.of(context).textTheme.subtitle2.color)
              ),
              Divider(height: 30.0, thickness: 0.5),
              Row(
                children: <Widget>[
                  Text('${StringUtils.ellipsis(order.orderItems.first.nameProduct, limit: 20)}', style: TextStyle(
                      fontSize: 14.0,
                      color: Theme.of(Get.context).textTheme.headline1.color
                  )),
                  if(order.orderItems.length != 1)
                    Text(' 외 ${order.orderItems.length-1}개', style: TextStyle(
                        fontSize: 14.0,
                        color: Theme.of(Get.context).textTheme.headline1.color
                    ))
                  else Text(' ${order.orderItems.first.quantity}개', style: TextStyle(
                      fontSize: 14.0,
                      color: Theme.of(Get.context).textTheme.headline1.color
                  )),
                ],
              )
              // OrderInfoCurrentItemBodyListItemWidget(order: order),
            ]
        )
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

  void _change() {
    Get.to(DeliveryDetailSitePage(Get.context.read<DeliverySiteModel>().userDeliverySite, oIdx: order.idx),
      arguments: DeliveryDetailPageType.FROM_ORDER_INFO,
      transition: Transition.cupertino,
      duration: Duration.zero
    );
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
}
