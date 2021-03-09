import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/domains/store/store_summary.dart';
import 'package:pomangam_client_flutter/providers/help/help_model.dart';
import 'package:pomangam_client_flutter/providers/order/time/order_time_model.dart';
import 'package:pomangam_client_flutter/providers/store/store_model.dart';
import 'package:pomangam_client_flutter/views/pages/store/review/store_review_page.dart';
import 'package:pomangam_client_flutter/views/pages/store/store_page.dart';
import 'package:pomangam_client_flutter/views/widgets/home/contents/item/home_contents_item_image_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/home/contents/item/home_contents_item_like_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/home/contents/item/home_contents_item_review_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/home/contents/item/home_contents_item_sub_title_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/home/contents/item/home_contents_item_title_widget.dart';
import 'package:provider/provider.dart';

class HomeContentsItemWidget extends StatefulWidget {

  final StoreSummary summary;
  final bool isFirst;

  HomeContentsItemWidget({Key key, this.summary, this.isFirst}): super(key: key);

  @override
  _HomeContentsItemWidgetState createState() => _HomeContentsItemWidgetState();
}

class _HomeContentsItemWidgetState extends State<HomeContentsItemWidget> {

  bool _isOrderable;
  bool _isOpening;

  @override
  void initState() {
    super.initState();
    DateTime userOrderDate = Provider.of<OrderTimeModel>(context, listen: false)
        .userOrderDate;
    bool isNextDay = userOrderDate?.isAfter(DateTime.now());
    _isOrderable = isNextDay || widget.summary.isOrderable();
    _isOpening = widget.summary.storeSchedule.isOpening; // isNextDay || widget.summary.storeSchedule.isOpening;
  }

  @override
  Widget build(BuildContext context) {

    List<String> imagePaths = List()
      ..add(widget.summary?.storeImageMainPath)
      ..addAll(widget.summary?.storeImageSubPaths);
    double opacity = _isOrderable && _isOpening ? 1 : 0.5;

    return Column(
      children: <Widget>[
        GestureDetector(
          key: widget.key,
          onTap: () => _isOrderable && _isOpening
              ? _navigateToStorePage()
              : {},
          child: Column(
            children: <Widget>[
              const Divider(height: kIsWeb ? 1.0 : 0.1),
              const SizedBox(height: 10),
              Column(
                key: widget.isFirst ? context.watch<HelpModel>().keyButtonHomeItem : null,
                children: [
                  HomeContentsItemTitleWidget(
                      brandImagePath: '${Endpoint.serverDomain}/${widget.summary.brandImagePath}',
                      title: widget.summary.name,
                      subTitle: _subTitle(),
                      subTitleColor: widget.summary.quantityOrderable <= 5 ? Theme.of(Get.context).primaryColor : Theme.of(context).textTheme.headline1.color,
                      avgStar: widget.summary.avgStar,
                      isFirst: widget.isFirst
                  ),
                  const SizedBox(height: 10),
                  HomeContentsItemImageWidget(
                      opacity: opacity,
                      height: 250.0,
                      imagePaths: imagePaths
                  ),
                ],
              ),
              const SizedBox(height: 10),
              HomeContentsItemLikeWidget(
                  opacity: opacity,
                  cntLike: widget.summary.cntLike,
                  couponType: widget.summary.couponType,
                  couponValue: widget.summary.couponValue
              ),
              const SizedBox(height: 7),
              HomeContentsItemSubTitleWidget(
                  opacity: opacity,
                  title: widget.summary.name,
                  description: widget.summary.description
              ),
              const SizedBox(height: 7),
            ],
          ),
        ),
        GestureDetector(
          onTap: _navigateToStoreReviewPage,
          child: HomeContentsItemReviewWidget(
            opacity: opacity,
            cntComment: widget.summary.cntReview
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 26.0)),
      ],
    );
  }

  void _navigateToStoreReviewPage() {
    Get.to(StoreReviewPage(sIdx: widget.summary.idx), transition: Transition.cupertino, duration: Duration.zero);
  }

  void _navigateToStorePage() {
    Get.to(StorePage(sIdx: widget.summary.idx, isOrderable: widget.summary.quantityOrderable > 0 && _isOrderable), transition: Transition.cupertino, duration: Duration.zero);
  }

  String _subTitle() {
    return _isOpening
      ? widget.summary.quantityOrderable > 0 && _isOrderable
        ? widget.summary.quantityOrderable <= 5
          ? '마감임박 ${widget.summary.quantityOrderable}개'
          : '주문가능 ${widget.summary.quantityOrderable}개'
        : '주문마감'
      : '${widget.summary.storeSchedule.pauseDescription}';
  }
}
