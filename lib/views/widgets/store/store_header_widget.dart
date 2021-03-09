import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/_bases/key/pmg_key.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/providers/store/store_model.dart';
import 'package:pomangam_client_flutter/views/widgets/store/store_brand_image_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/store/store_score_widget.dart';
import 'package:provider/provider.dart';

class StoreHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      key: PmgKeys.storeHeader,
      child: Container(
        padding: EdgeInsets.only(left: 15.0, right: 10.0, top: 7.0, bottom: 15.0),
        child: Consumer<StoreModel>(
          builder: (_, model, child) {
            return Row(
              children: <Widget>[
                StoreBrandImageWidget(
                    brandImagePath: '${Endpoint.serverDomain}/${model.store?.brandImagePath}'
                ),
                Expanded(
                  child: StoreScoreWidget(
                    avgStar: model.store?.avgStar ?? 0,
                    cntLike: model.store?.cntLike ?? 0,
                    cntComment: model.store?.cntReview ?? 0
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
