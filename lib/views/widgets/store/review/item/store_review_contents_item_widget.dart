import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_divider.dart';
import 'package:pomangam_client_flutter/views/widgets/store/review/item/store_review_contents_item_image_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/store/review/item/store_review_contents_item_review_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/store/review/item/store_review_contents_item_sub_title_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/store/review/item/store_review_contents_item_title_widget.dart';

class StoreReviewContentsItemWidget extends StatelessWidget {

  final userNickname;
  final productName;
  final String title;
  final double avgStar;
  final List<String> imagePaths;
  final String description;
  final String ownerReplyContents;
  final String reviewDate;
  final String replyDate;
  final bool isOwn;

  StoreReviewContentsItemWidget({
    this.userNickname = '',
    this.productName = '',
    this.title = '',
    this.avgStar = 0,
    this.imagePaths,
    this.description = '',
    this.ownerReplyContents,
    this.reviewDate = '',
    this.replyDate = '',
    this.isOwn
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          StoreReviewContentsItemTitleWidget(
            userNickname: userNickname,
            avgStar: avgStar,
            date: reviewDate
          ),
          const SizedBox(height: 10),
          imagePaths == null || imagePaths.isEmpty
            ? Container()
            : Column(
              children: <Widget>[
                StoreReviewContentsItemImageWidget(imagePaths: imagePaths),
                const Padding(padding: EdgeInsets.only(bottom: 15.0)),
              ],
            ),
          StoreReviewContentsItemSubTitleWidget(
            title: productName,
            description: description,
            date: reviewDate,
          ),
          if(isOwn) const SizedBox(height: 10),
          if(isOwn) Container(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: _edit,
                  child: Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text('수정', style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold
                      )),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: _delete,
                  child: Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text('삭제', style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if(ownerReplyContents != null && ownerReplyContents != 'null') const SizedBox(height: 20),
          if(ownerReplyContents != null && ownerReplyContents != 'null') StoreReviewContentsItemReviewWidget(
            commentContents: ownerReplyContents,
            date: replyDate
          ),
          const SizedBox(height: 30),
          CustomDivider(),
        ],
      ),
    );
  }

  void _edit() {
    print('edit cc');
  }

  void _delete() {
    print('del cc');
  }
}
