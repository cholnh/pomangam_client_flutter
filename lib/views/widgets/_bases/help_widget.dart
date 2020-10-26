import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/domains/order/time/order_time.dart';
import 'package:pomangam_client_flutter/providers/help/help_model.dart';
import 'package:pomangam_client_flutter/providers/home/home_contents_view_model.dart';
import 'package:pomangam_client_flutter/providers/order/time/order_time_model.dart';
import 'package:pomangam_client_flutter/views/widgets/home/contents/item/home_contents_type.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

List<TargetFocus> targetFocus() {
  List<TargetFocus> targets = List();
  HelpModel helpModel = Get.context.read<HelpModel>();

  Get.context.read<HomeContentsViewModel>().changeHomeContentsType(HomeContentsType.LIST);

  targets.add(
    TargetFocus(
      identify: "Target 1",
      keyTarget: helpModel.keyButton1,
      shape: ShapeLightFocus.RRect,
      enableOverlayTab: true,
      contents: [
        ContentTarget(
          align: AlignContent.bottom,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '주문 장소를 선택해요.',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                SizedBox(height: 20),
                Text(
                  '받는 장소마다 도착시간이 다를 수 있으니 유의하세요!',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          )
        )
      ],
    )
  );

  List<OrderTime> orderTimes = Get.context.read<OrderTimeModel>().orderTimes;

  targets.add(
    TargetFocus(
      identify: "Target 2",
      keyTarget: helpModel.keyButton2,
      shape: ShapeLightFocus.RRect,
      enableOverlayTab: true,
      contents: [
        ContentTarget(
          align: AlignContent.bottom,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '배달 도착 시간을 선택해요.',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                if(!orderTimes.isNullOrBlank) Container(
                  margin: const EdgeInsets.only(top: 15.0),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.5,
                      color: Colors.white
                    )
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('주문 마감시간', style: TextStyle(
                              color: Colors.white
                          )),
                          Icon(Icons.arrow_right, color: Colors.white, size: 25),
                          Text('도착시간', style: TextStyle(
                              color: Colors.white
                          ))
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(color: Colors.white, height: 0.5, thickness: 0.5),
                      SizedBox(height: 10),
                      for(int i=0; i<(orderTimes.length < 5 ? orderTimes.length : 5); i++) Column(
                        children: [
                          if(i < 2) Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${_time(orderTimes[i].getOrderEndDateTime())} 마감', style: TextStyle(
                                  color: Colors.white
                              )),
                              Text('${_time(orderTimes[i].getArrivalDateTime())} 도착', style: TextStyle(
                                  color: Colors.white
                              )),
                            ],
                          )
                          else Text('.', style: TextStyle(color: Colors.white)),
                          SizedBox(height: 5),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        )
      ],
    )
  );

  targets.add(
      TargetFocus(
        identify: "Target home item",
        keyTarget: helpModel.keyButtonHomeItem,
        shape: ShapeLightFocus.RRect,
        enableOverlayTab: true,
        contents: [
          ContentTarget(
              align: AlignContent.top,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '음식점을 선택해요',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '여러 음식점들의 음식들을 한 번에 맛볼 수도 있어요!',
                      style: TextStyle(color: Colors.white),
                    ),
                    Row(
                      children: [
                        Text(
                          '한 개를 시키든, 여러 개를 시키든 ',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '배달비는 0원',
                          style: TextStyle(color: Theme.of(Get.context).primaryColor),
                        ),
                      ],
                    )
                  ],
                ),
              )
          )
        ],
      )
  );

  targets.add(
      TargetFocus(
        identify: "Target 3",
        keyTarget: helpModel.keyButton3,
        shape: ShapeLightFocus.RRect,
        enableOverlayTab: true,
        contents: [
          ContentTarget(
              align: AlignContent.bottom,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '음식점의 현재 주문 가능 개수에요.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '주문이 마감되었으면 다음 배달시간에 이용할 수 있어요!',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )
          )
        ],
      )
  );

  targets.add(
      TargetFocus(
        identify: "Target 4",
        keyTarget: helpModel.keyButton4,
        shape: ShapeLightFocus.RRect,
        enableOverlayTab: true,
        contents: [
          ContentTarget(
              align: AlignContent.bottom,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '모든 음식점 전체보기도 가능해요.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                  ],
                ),
              )
          )
        ],
      )
  );

  targets.add(
      TargetFocus(
        identify: "Target 5",
        keyTarget: helpModel.keyButton5,
        shape: ShapeLightFocus.RRect,
        enableOverlayTab: true,
        contents: [
          ContentTarget(
              align: AlignContent.top,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '주문 내역은 이곳에서 확인 가능해요.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '이제 음식점을 고르고 원하는 음식을 주문해 보세요!',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              )
          )
        ],
      )
  );

  return targets;
}

String _time(DateTime dt) {
  return '${dt.hour}시' + (dt.minute == 0 ? '' : ' ${dt.minute}분');
}