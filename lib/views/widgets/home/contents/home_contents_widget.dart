import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/_bases/key/pmg_key.dart';
import 'package:pomangam_client_flutter/providers/home/home_contents_view_model.dart';
import 'package:pomangam_client_flutter/providers/store/store_summary_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:pomangam_client_flutter/views/widgets/home/contents/grid_item/home_contents_grid_item_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/home/contents/item/home_contents_item_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/home/contents/item/home_contents_type.dart';
import 'package:provider/provider.dart';

class HomeContentsWidget extends StatelessWidget {

  HomeContentsWidget();

  @override
  Widget build(BuildContext context) {
    StoreSummaryModel storeSummaryModel = context.watch();
    if(storeSummaryModel.isFetching) return _shimmer();
    if(storeSummaryModel.stores.isEmpty) return _empty();

    if(context.watch<HomeContentsViewModel>().contentsType == HomeContentsType.LIST) {
      return SliverList(
        key: PmgKeys.deliveryContents,
        delegate: SliverChildBuilderDelegate((context, index) {
          return index >= storeSummaryModel.stores.length
            ? Container()
            : HomeContentsItemWidget(
              key: PmgKeys.homeContentsItem(storeSummaryModel.stores[index].idx),
              summary: storeSummaryModel.stores[index],
              isFirst: index == 0
            );
        },
          childCount: storeSummaryModel.hasReachedMax
            ? storeSummaryModel.stores.length
            : storeSummaryModel.stores.length + 1
        ),
      );
    } else {
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        sliver: SliverGrid(
          key: PmgKeys.deliveryContents,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            return index >= storeSummaryModel.stores.length
              ? Container()
              : HomeContentsGridItemWidget(
                key: PmgKeys.homeContentsItem(storeSummaryModel.stores[index].idx),
                summary: storeSummaryModel.stores[index]
              );
          },
            childCount: storeSummaryModel.hasReachedMax
              ? storeSummaryModel.stores.length
              : storeSummaryModel.stores.length + 1
          ),
        ),
      );
    }
  }

  Widget _shimmer() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const Divider(height: kIsWeb ? 1.0 : 0.1),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomShimmer(width: 34, height: 34, borderRadius: BorderRadius.circular(50)),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CustomShimmer(width: 70, height: 10),
                        const SizedBox(height: 2),
                        CustomShimmer(width: 50, height: 8)
                      ],
                    ),
                  ],
                ),
                CustomShimmer(width: 70, height: 10)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                CustomShimmer(height: 250, borderRadius: BorderRadius.zero),
                const SizedBox(height: 10),
                CustomShimmer(width: 70, height: 10),
                const SizedBox(height: 7),
                CustomShimmer(width: 200, height: 10),
                const SizedBox(height: 7),
                CustomShimmer(width: 100, height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _empty() {
    return SliverToBoxAdapter(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('주문가능한 업체가 없습니다.', style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 14)),
        ),
      ),
    );
  }
}
