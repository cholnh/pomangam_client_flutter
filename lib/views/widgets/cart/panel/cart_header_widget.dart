import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:pomangam_client_flutter/providers/cart/cart_model.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client_flutter/views/pages/deliverysite/detail/delivery_detail_page_type.dart';
import 'package:pomangam_client_flutter/views/pages/deliverysite/detail/delivery_detail_site_page.dart';
import 'package:provider/provider.dart';

class CartHeaderWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0.0),
          child: Consumer<CartModel>(
            builder: (_, model, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (model.cart.detail == null) Container() else Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RichText(
                        textAlign: TextAlign.left,
                        softWrap: true,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).textTheme.headline1.color
                          ),
                          children: <TextSpan>[
                            TextSpan(text: '${model.cart.detail.name}', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.headline1.color)),
                            model.cart.subAddress != null && model.cart.subAddress.isNotEmpty
                              ? TextSpan(text: ' ${model.cart.subAddress}', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.headline1.color))
                              : TextSpan(text: ''),
                            TextSpan(text: ' (으)로 배달'),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: _change,
                        child: Text('변경', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(Get.context).primaryColor, fontSize: 13.0))
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 3.0)),
                  Text(
                    '${_textDate(model.cart.orderDate)} ${_textTime(model.cart.orderTime.arrivalTime)} 도착',
                    style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5))
                  ),
                ],
              );
            },
          ),
        ),
        Divider(height: 40.0, thickness: 3.0, color: Colors.black.withOpacity(0.03))
      ],
    );
  }

  void _change() {
    Get.to(DeliveryDetailSitePage(
      Get.context.read<DeliverySiteModel>().userDeliverySite),
      arguments: DeliveryDetailPageType.FROM_CART,
      transition: Transition.cupertino,
      duration: Duration.zero
    );
  }

  String _textDate(DateTime dt) {
    DateTime today = DateTime.now();
    if(dt.year == today.year && dt.month == today.month && dt.day == today.day) {
      return '오늘';
    }
    return DateFormat('yyyy년 MM월 dd일').format(dt);
  }

  String _textTime(String time) {
    List<String> t = time.split(':');
    String textHour = '${t[0]}시';
    String textMinute = t[1] == '00' ? '' : ' ${t[1]}분';
    return textHour + textMinute;
  }
}
