import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/providers/store/store_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/store/review/item/store_review_contents_item_widget.dart';
import 'package:provider/provider.dart';

class StoreReviewDetailPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreModel>(
        builder: (_, model, __) {
          return  Scaffold(
            appBar: BasicAppBar(
              leadingIcon: Icon(CupertinoIcons.back, size: 20, color: Colors.black),
              title: '리뷰',
              elevation: 1.0,
            ),
            body: SafeArea(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Column(
                      children: <Widget>[
                        StoreReviewContentsItemWidget(
                          userNickname: '낙지22',
                          productName: '싸이버거 세트',
                          title: '정말맛있어요!',
                          avgStar: 4.5,
                          description: '리뷰 처음써봅니다. 정말맛있어요. 강추강추!! 또 시키러 갑니다 ㅎㅎ',
                          imagePaths: List()..add('assets/images/dsites/1/stores/1/1.png')..add('assets/images/dsites/1/stores/1/2.png')..add('assets/images/dsites/1/stores/1/3.png'),
                          ownerReplyContents: '리뷰 감사드립니다~ 쿠폰 증정해드렸습니다.',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}