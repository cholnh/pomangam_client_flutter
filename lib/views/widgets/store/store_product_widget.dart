import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pomangam_client_flutter/_bases/key/pmg_key.dart';
import 'package:pomangam_client_flutter/providers/product/product_summary_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:pomangam_client_flutter/views/widgets/store/store_product_item_widget.dart';
import 'package:provider/provider.dart';

class StoreProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductSummaryModel>(
      builder: (_, model, child) {
        if(model.isFetching) return _shimmer();
        if(model.productSummaries.isEmpty) return _empty();
        return SliverGrid(
          key: PmgKeys.storeProduct,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            return StoreProductItemWidget(
                key: PmgKeys.storeProductItem(model.productSummaries[index].idx),
                summary: model.productSummaries[index]
            );
          },
          childCount: model.productSummaries.length)
        );
      },
    );
  }

  Widget _shimmer() {
    return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          return CustomShimmer(borderRadius: BorderRadius.zero);
        }, childCount: 3)
    );
  }

  Widget _empty() {
    return SliverToBoxAdapter(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text('주문가능한 메뉴가 없습니다.', style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 14)),
        ),
      ),
    );
  }
}