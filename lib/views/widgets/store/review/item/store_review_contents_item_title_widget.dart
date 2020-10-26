import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreReviewContentsItemTitleWidget extends StatelessWidget {

  final String userNickname;
  final String productName;
  final double avgStar;
  final String date;

  StoreReviewContentsItemTitleWidget({this.userNickname, this.productName, this.avgStar, this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: CircleAvatar(
                  child: Image(
                    image: AssetImage('assets/logo_transparant.png'),
                    width: 24.0,
                    height: 24.0,
                    fit: BoxFit.fill,
                  ),
                  foregroundColor: Theme.of(Get.context).primaryColor,
                  backgroundColor: Theme.of(Get.context).primaryColor
                ),
                width: 34.0,
                height: 34.0,
                padding: const EdgeInsets.all(0.5),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  shape: BoxShape.circle,
                )
              ),
              Padding(padding: EdgeInsets.only(right: 10.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    userNickname,
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.headline1.color)
                  ),
                  Padding(padding: EdgeInsets.only(top: 1.0)),
                  Text(
                    '$date',
                    style: TextStyle(fontSize: 11.0, color: Colors.black.withOpacity(0.5))
                  )
                ],
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: _star(avgStar),
          ),
        ],
      ),
    );
  }

  List<Widget> _star(double avgStar) {
    final double size = 16;

    int q = avgStar <= 0 ? 0 : avgStar ~/ 1;      // 몫
    double r = avgStar <= 0 ? 0 : avgStar % q;    // 나머지

    q = q > 5 ? 5 : q;
    int cnt = 0;
    List<Widget> widgets = List();
    for(int i=0; i<q; i++) {
      widgets.add(Icon(Icons.star, color: Theme.of(Get.context).primaryColor, size: size));
      cnt++;
    }
    if(r != 0.0) {
      widgets.add(Icon(Icons.star_half, color: Theme.of(Get.context).primaryColor, size: size));
      cnt++;
    }
    for(int i=0; i<5-cnt; i++) {
      widgets.add(Icon(Icons.star_border, color: Theme.of(Get.context).primaryColor, size: size));
    }
    return widgets;
  }
}
