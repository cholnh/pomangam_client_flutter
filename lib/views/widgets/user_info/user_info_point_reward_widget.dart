import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/domains/user/point_rank/point_rank.dart';
import 'package:pomangam_client_flutter/providers/point/point_model.dart';
import 'package:provider/provider.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

class UserInfoPointRewardWidget extends StatelessWidget {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    PointModel pointModel = context.watch<PointModel>();

    return Container(
      width: 300,
      child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(pointModel.isFetching) _loading()
            else SizedBox(
              height: 250,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: PageView(
                        children: _buildPages(pointModel.pointRanks),
                        controller: _controller,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: ScrollingPageIndicator(
                        dotColor: Colors.black12,
                        dotSelectedColor: Theme.of(context).primaryColor,
                        dotSize: 5,
                        dotSelectedSize: 6,
                        dotSpacing: 9,
                        controller: _controller,
                        itemCount: pointModel.pointRanks.length,
                        orientation: Axis.horizontal
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  List<Widget> _buildPages(List<PointRank> pointRanks) {
    double width = MediaQuery.of(Get.context).size.width;
    return pointRanks.map((pointRank) => GestureDetector(
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text('Lv${pointRank.level} ${pointRank.title} 등급', style: TextStyle(
                color: Theme.of(Get.context).textTheme.headline1.color,
                fontWeight: FontWeight.bold,
                fontSize: 16
              )),
            ),
            SizedBox(height: 15),
            Divider(height: kIsWeb ? 1.0 : 0.5, thickness: 0.5, color: Colors.black),
            SizedBox(height: 15),
            if(!pointRank.percentSavePoint.isNullOrBlank) Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('포인트 적립률', style: TextStyle(
                    color: Theme.of(Get.context).textTheme.headline1.color,
                    fontWeight: FontWeight.normal,
                    fontSize: 15
                )),
                Text('${pointRank.percentSavePoint}%', style: TextStyle(
                    color: Theme.of(Get.context).textTheme.headline1.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ))
              ],
            ),
            if(!pointRank.percentSavePoint.isNullOrBlank) SizedBox(height: 10),
            if(!pointRank.priceSavePoint.isNullOrBlank) Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('포인트 적립금액', style: TextStyle(
                    color: Theme.of(Get.context).textTheme.headline1.color,
                    fontWeight: FontWeight.normal,
                    fontSize: 15
                )),
                Text('${pointRank.priceSavePoint}원', style: TextStyle(
                    color: Theme.of(Get.context).textTheme.headline1.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ))
              ],
            ),
            if(!pointRank.priceSavePoint.isNullOrBlank) SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('레벨업 혜택', style: TextStyle(
                    color: Theme.of(Get.context).textTheme.headline1.color,
                    fontWeight: FontWeight.normal,
                    fontSize: 15
                )),
                Text(pointRank.level == 1 ? '없음' : '${pointRank.rewardCouponPrice}원 쿠폰 제공', style: TextStyle(
                    color: Theme.of(Get.context).textTheme.headline1.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ))
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('레벨업 조건', style: TextStyle(
                    color: Theme.of(Get.context).textTheme.headline1.color,
                    fontWeight: FontWeight.normal,
                    fontSize: 15
                )),
                Text('누적 ${pointRank.nextLowerLimitOrderCount}번 주문', style: TextStyle(
                    color: Theme.of(Get.context).textTheme.headline1.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ))
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: Text('📢 현재 등급별 혜택 서비스 준비중입니다 !', style: TextStyle(
                fontSize: 16,
                color: Theme.of(Get.context).primaryColor
              )),
            ),
            Center(
              child: Text('빠른 시간안에 찾아뵙겠습니다.', style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(Get.context).primaryColor
              )),
            )
          ],
        )
      ),
    )).toList();
  }

  Widget _loading() {
    return SizedBox(
      height: 250,
      child: Center(child: CupertinoActivityIndicator()),
    );
  }
}
