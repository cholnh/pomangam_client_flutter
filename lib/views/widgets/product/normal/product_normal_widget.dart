import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/providers/product/sub/product_sub_category_model.dart';
import 'package:pomangam_client_flutter/views/widgets/product/normal/contents/product_contents_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/product/sub/product_sub_category_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/product/sub/product_sub_widget.dart';
import 'package:provider/provider.dart';

class ProductNormalWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        ProductContentsWidget(),
        ProductSubCategoryWidget(
          pinned: true,
          onSelected: _onCategoryItemSelected,
        ),
        ProductSubWidget(),
        SliverToBoxAdapter(
          child: Container(height: 55.0),
        )
      ],
    );
  }

  void _onCategoryItemSelected(int idxSelected, int idxProductSubCategory) {
    Get.context.read<ProductSubCategoryModel>().changeIdxSelectedCategory(idxSelected);
    Get.context.read<ProductModel>().changeIdxProductSubCategory(idxProductSubCategory == null ? 0 : idxProductSubCategory);
  }
}
