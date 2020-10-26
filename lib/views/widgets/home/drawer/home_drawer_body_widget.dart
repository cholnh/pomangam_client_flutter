import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/views/pages/event/event_page.dart';
import 'package:pomangam_client_flutter/views/pages/home/home_page.dart';
import 'package:pomangam_client_flutter/views/pages/notice/notice_page.dart';
import 'package:pomangam_client_flutter/views/pages/order/order_info/order_info_page.dart';
import 'package:pomangam_client_flutter/views/pages/order/order_subscribe_info/order_subscribe_info_page.dart';
import 'package:pomangam_client_flutter/views/pages/user_info/user_info_page.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/sign_modal.dart';
import 'package:provider/provider.dart';

class HomeDrawerBodyWidget extends StatelessWidget {

  final double height;

  HomeDrawerBodyWidget({this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () => Get.to(OrderInfoPage(), duration: Duration.zero),
            child: Material(
              color: Color.fromRGBO(0x30, 0x30, 0x30, 1.0),
              child: Container(
                height: 50.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          '내 주문',
                          style: TextStyle(fontSize: 14.0, color: Theme.of(Get.context).backgroundColor)
                      ),
//                      Padding(padding: const EdgeInsets.only(right: 7.0)),
//                      Container(
//                        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
//                        decoration: BoxDecoration(
//                          shape: BoxShape.circle,
//                          color: Theme.of(Get.context).primaryColor,
//                        ),
//                        child: FittedBox(
//                          child: Text(
//                              '1',
//                              style: TextStyle(fontSize: 12.0, color: Theme.of(Get.context).backgroundColor, fontWeight: FontWeight.bold)
//                          ),
//                        ),
//                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(color: Colors.black.withOpacity(0.1), height: 0.0, thickness: 0.5),
          GestureDetector(
            onTap: () => Get.to(OrderSubscribeInfoPage(), duration: Duration.zero),
            child: Material(
              color: Color.fromRGBO(0x30, 0x30, 0x30, 1.0),
              child: Container(
                height: 50.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                          '정기 배송',
                          style: TextStyle(fontSize: 14.0, color: Theme.of(Get.context).backgroundColor)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(thickness: 8.0, color: Colors.black.withOpacity(0.1)),
          //Divider(color: Colors.black.withOpacity(0.1), height: 0.0, thickness: 0.5),
          GestureDetector(
            onTap: () => Get.to(EventPage(), duration: Duration.zero),
            child: Material(
              color: Color.fromRGBO(0x30, 0x30, 0x30, 1.0),
              child: Container(
                height: 50.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                          '이벤트',
                          style: TextStyle(fontSize: 14.0, color: Theme.of(Get.context).backgroundColor)
                      ),
                      Padding(padding: const EdgeInsets.only(right: 7.0)),
                      Text(
                          'new',
                          style: TextStyle(fontSize: 11.0, color: Theme.of(Get.context).primaryColor, fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(color: Colors.black.withOpacity(0.1), height: 0.0, thickness: 0.5),
          GestureDetector(
            onTap: () => Get.to(NoticePage(), duration: Duration.zero),
            child: Material(
              color: Color.fromRGBO(0x30, 0x30, 0x30, 1.0),
              child: Container(
                height: 50.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                          '공지사항',
                          style: TextStyle(fontSize: 14.0, color: Theme.of(Get.context).backgroundColor)
                      ),
                      Padding(padding: const EdgeInsets.only(right: 7.0)),
                      Text(
                          'new',
                          style: TextStyle(fontSize: 11.0, color: Theme.of(Get.context).primaryColor, fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(color: Colors.black.withOpacity(0.1), height: 0.0, thickness: 0.5),
//          Container(
//            height: 50.0,
//            child: Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Text(
//                      '친구초대',
//                      style: TextStyle(fontSize: 14.0, color: Theme.of(Get.context).backgroundColor)
//                  ),
//                ],
//              ),
//            ),
//          ),
//          Divider(color: Colors.black.withOpacity(0.1), height: 0.0, thickness: 0.5),
//          Container(
//            height: 50.0,
//            child: Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Text(
//                      '문의하기',
//                      style: TextStyle(fontSize: 14.0, color: Theme.of(Get.context).backgroundColor)
//                  ),
//                ],
//              ),
//            ),
//          ),
//          Divider(color: Colors.black.withOpacity(0.1), height: 0.0, thickness: 0.5),
        ],
      ),
    );
  }
}
