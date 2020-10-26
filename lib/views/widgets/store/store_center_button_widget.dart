import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/providers/store/store_model.dart';
import 'package:pomangam_client_flutter/views/pages/store/review/store_review_page.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:provider/provider.dart';

class StoreCenterButtonWidget extends StatelessWidget {

  final int wPadding = 20;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width/2 - wPadding;

    return SliverToBoxAdapter(
      child: Consumer<StoreModel>(
        builder: (_, model, child) {
          bool isCoupon = false; // model.summary?.couponType != null && model.summary?.couponType != 0;
          bool isAlreadyIssueCoupon = true;  // Todo: isAlreadyIssueCoupon
          bool isFetching = model.isStoreFetching;

          return Column(
            children: <Widget>[
              // if (isCoupon && !isFetching) SizedBox(
              //   height: 40.0,
              //   width: MediaQuery.of(context).size.width - 26,
              //   child: FlatButton(
              //     onPressed: _onPressedCouponButton,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(5.0),
              //       side: BorderSide(color: isAlreadyIssueCoupon ? Colors.white : Theme.of(Get.context).primaryColor)
              //     ),
              //     color: isAlreadyIssueCoupon ? Color.fromRGBO(0, 0, 0, 0.1) : Theme.of(Get.context).backgroundColor,
              //     child: Container(
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: <Widget>[
              //           Text(
              //             isAlreadyIssueCoupon
              //               ? '${model.summary?.couponValue}원 쿠폰 받기 완료'
              //               : '${model.summary?.couponValue}원 쿠폰 받기',
              //             style: TextStyle(fontSize: 13.0, color: isAlreadyIssueCoupon ? Colors.black38 : Theme.of(Get.context).primaryColor, fontWeight: FontWeight.bold),
              //             textAlign: TextAlign.center
              //           ),
              //           Container(
              //             padding: EdgeInsets.only(top: 3.0, left: 3.0),
              //             child: Icon(isAlreadyIssueCoupon ? Icons.check : Icons.get_app, size: 13.0, color: isAlreadyIssueCoupon ? Colors.black38 : Theme.of(Get.context).primaryColor)
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ) else Container(),
              if (isCoupon && isFetching) const SizedBox(height: 15)
              else Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if(isFetching) CustomShimmer(width: w, height: 27, borderRadius: BorderRadius.circular(5.0))
                  else SizedBox(
                    height: 27,
                    width: w,
                    child: FlatButton(
                      onPressed: () => _onPressedDetailButton(model),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Colors.black12)
                      ),
                      color: Theme.of(Get.context).backgroundColor,
                      child: Container(
                        child: Text(
                          model.isStoreDescriptionOpened ? '상세정보 접기' : '상세정보',
                          style: TextStyle(fontSize: 13.0, color: Theme.of(context).textTheme.headline1.color),
                          textAlign: TextAlign.center
                        ),
                      ),
                    ),
                  ),
                  if(isFetching) CustomShimmer(width: w, height: 27, borderRadius: BorderRadius.circular(5.0))
                  else SizedBox(
                    height: 27,
                    width: w,
                    child: FlatButton(
                      onPressed: () => _onPressedReviewButton(model.store.idx),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Colors.black12)
                      ),
                      color: Theme.of(Get.context).backgroundColor,
                      child: Container(
                        child: Text('리뷰보기', style: TextStyle(fontSize: 13.0, color: Theme.of(context).textTheme.headline1.color), textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      ),
    );
  }

  void _onPressedCouponButton() {
    print('coupon button!!');
  }

  void _onPressedDetailButton(StoreModel model) {
    model.toggleIsStoreDescriptionOpened();
  }

  void _onPressedReviewButton(int sIdx) {
    Get.to(StoreReviewPage(sIdx: sIdx), transition: Transition.cupertino, duration: Duration.zero);
  }
}
