import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/domains/product/product_type.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/providers/product/sub/product_sub_category_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:pomangam_client_flutter/views/widgets/product/custom/contents/product_custom_contents_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/product/custom/contents/product_custom_sub_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/product/custom/custom_2/product_custom_2_image_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/product/custom/custom_3/product_custom_3_image_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/product/custom/custom_4/product_custom_4_image_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/product/custom/custom_5/product_custom_5_image_widget.dart';
import 'package:provider/provider.dart';

class ProductCustomWidget extends StatelessWidget {

  final ProductType type;
  final ScrollController scrollController = ScrollController();
  final GlobalKey scrollTarget = GlobalKey();

  ProductCustomWidget({this.type});

  @override
  Widget build(BuildContext context) {
    ProductModel productModel = context.watch();

    return Container(
      color: productModel.isProductFetching ? Colors.white : Colors.transparent,
      child: Column(
        children: <Widget>[
          if(productModel.isProductFetching) _shimmer()
          else Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[300],
                  width: 1
                )
              )
            ),
            child: _customImage()
          ),
          Flexible(
            child: CustomScrollView(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                ProductCustomContentsWidget(),
                // ProductSubCategoryWidget(
                //   pinned: false,
                //   onSelected: _onCategoryItemSelected,
                // ),
                SliverToBoxAdapter(key: scrollTarget, child: Container()),
                if(productModel.isProductFetching) _subShimmer()
                else ProductCustomSubWidget(),
                SliverToBoxAdapter(
                  child: Container(height: 55.0),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _customImage() {
    switch(type) {
      case ProductType.CUSTOMIZING_2:
        return ProductCustom2ImageWidget(
          onSelected: _onCategoryItemSelected,
        );
      case ProductType.CUSTOMIZING_3:
        return ProductCustom3ImageWidget(
          onSelected: _onCategoryItemSelected,
        );
      case ProductType.CUSTOMIZING_4:
        return ProductCustom4ImageWidget(
          onSelected: _onCategoryItemSelected,
        );
      case ProductType.CUSTOMIZING_5:
        return ProductCustom5ImageWidget(
          onSelected: _onCategoryItemSelected,
        );
      case ProductType.CUSTOMIZING_6:
      default:
        return _shimmer();
    }
  }

  Widget _shimmer() => Container(
    color: Colors.white,
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: CustomShimmer(width: MediaQuery.of(Get.context).size.width-120, height: 160),
  );

  Widget _subShimmer() => SliverToBoxAdapter(
    child: Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left:10, right: 10),
              child: CustomShimmer(width: MediaQuery.of(Get.context).size.width, height: 40),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left:10, right: 10),
              child: CustomShimmer(width: MediaQuery.of(Get.context).size.width, height: 40),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left:10, right: 10),
              child: CustomShimmer(width: MediaQuery.of(Get.context).size.width, height: 40),
            ),
          ],
        ),
      ),
    )
  );

  void _onCategoryItemSelected(int idxProductSubCategory) async {
    Get.context.read<ProductSubCategoryModel>().changeIdxSelectedCategory(idxProductSubCategory);
    Get.context.read<ProductModel>().changeIdxProductSubCategory(idxProductSubCategory == null ? 0 : idxProductSubCategory);
    Scrollable.ensureVisible(scrollTarget.currentContext, duration: Duration(milliseconds: 500), curve: Curves.ease);
  }
}
