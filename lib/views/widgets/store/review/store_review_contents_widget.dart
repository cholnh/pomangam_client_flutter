import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/domains/store/review/store_review.dart';
import 'package:pomangam_client_flutter/views/widgets/store/review/item/store_review_contents_item_widget.dart';

class StoreReviewContentsWidget extends StatelessWidget {

  final List<StoreReview> reviews;

  StoreReviewContentsWidget({this.reviews});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          for(StoreReview review in reviews)
            StoreReviewContentsItemWidget(
              userNickname: '${review.nickname}',
              productName: '${review.productName}',
              title: '${review.title}',
              avgStar: review.star,
              description: '${review.contents}',
              imagePaths: _imagePaths(review),
              ownerReplyContents: '${review.ownerReply}',
              reviewDate: '${_date(review.modifyDate)}',
              replyDate: '${_date(review.ownerReplyModifyDate)}',
              isOwn: review.isOwn
            ),
        ],
      ),
    );
  }

  String _date(DateTime dt) {
    if(dt != null) {
      DateTime now = DateTime.now();
      Duration diff = now.difference(dt);
      int year = diff.inDays ~/ 365;
      int month = (diff.inDays - (365 * year)) ~/ 30;
      int day = (diff.inDays - (365 * year) - (30 * month));
      if(year == 0 && month == 0 && day == 0) return '오늘';
      if(year == 0 && month == 0 && day == 1) return '어제';
      if(year == 0 && month == 0 && day > 1 && day < 7) return '$day일 전';
      if(year == 0 && month == 0 && day >= 7 && day < 14) return '1주 전';
      if(year == 0 && month == 0 && day >= 14 && day < 21) return '2주 전';
      if(year == 0 && month == 0 && day >= 21 && day < 28) return '3주 전';
      if(year == 0 && month == 0 && day >= 29) return '4주 전';
      if(year == 0 && month == 1) return '지난 달';
      if(year == 0 && month > 1) return '$month개월 전';
      if(year == 1) return '작년';
      if(year > 1) return '$year년 전';
    }
    return '';
  }

  List<String> _imagePaths(StoreReview review) {
    if(review.storeReviewImageMainPath == null || review.storeReviewImageSubPaths == null) {
      return null;
    }
    return List()..add(review.storeReviewImageMainPath)..addAll(review.storeReviewImageSubPaths);
  }
}
