import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:provider/provider.dart';

class HomeContentsItemLikeWidget extends StatelessWidget {

  final double opacity;
  final int cntLike;
  final int couponType;
  final int couponValue;

  HomeContentsItemLikeWidget({this.opacity = 1.0, this.cntLike = 0, this.couponType = 0, this.couponValue = 0});

  @override
  Widget build(BuildContext context) {
    bool isFetching = context.watch<ProductModel>().isProductFetching;

    return Opacity(
      opacity: opacity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: isFetching
              ? CustomShimmer(height: 15, width: 50)
              : Text(
                '좋아요 $cntLike개',
                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.headline1.color)
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: couponType == 0 || isFetching
              ? Container()
              : Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(Get.context).primaryColor, width: 1.0)
                ),
                child: Text('$couponValue원 쿠폰', style: TextStyle(color: Theme.of(Get.context).primaryColor, fontSize: 11, fontWeight: FontWeight.w600)),
              )
          ),
        ],
      ),
    );
  }
}
