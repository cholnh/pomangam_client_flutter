import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pomangam_client_flutter/_bases/key/pmg_key.dart';
import 'package:pomangam_client_flutter/domains/product/category/product_category.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client_flutter/providers/product/product_summary_model.dart';
import 'package:pomangam_client_flutter/providers/store/store_model.dart';
import 'package:pomangam_client_flutter/providers/store/store_product_category_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:provider/provider.dart';

class StoreProductCategoryWidget extends StatelessWidget {

  final int sIdx;
  final Function onChangedCategory;

  StoreProductCategoryWidget({this.sIdx, this.onChangedCategory});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      key: PmgKeys.storeProductCategory,
      backgroundColor: Theme.of(Get.context).backgroundColor,
      floating: true,
      pinned: true,
      centerTitle: false,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0.8,
      title: Container(
        height: 60,
        child: Consumer<StoreProductCategoryModel>(
          builder: (_, categoryModel, child) {
            int selected = categoryModel.idxSelectedCategory;
            return Consumer<StoreModel>(
              builder: (_, storeModel, child) {
                List<ProductCategory> productCategories = storeModel?.store?.productCategories;
                int count = storeModel.isStoreFetching ? 5 : (productCategories == null ? 0 : productCategories.length+1);

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: count,
                  itemBuilder: (context, index) {
                    if(storeModel.isStoreFetching) {
                    return _shimmer();
                    } else {
                      return GestureDetector(
                        onTap: index == 0
                          ? () => _onSelected(context, index, null)
                          : () => _onSelected(context, index, productCategories[index-1].idx),
                        child: Card(
                          semanticContainer: true,
                          color: index == selected ? Theme.of(context).primaryColor : Theme.of(context).backgroundColor,
                          child: Container(
                              margin: EdgeInsets.only(left: 15.0, right: 15.0),
                              padding: EdgeInsets.all(5.0),
                              alignment: Alignment.center,
                              child: Text(index == 0
                                  ? '전체'
                                  : '${productCategories[index-1].categoryTitle}',
                                style: TextStyle(color: index == selected ? Colors.white : Colors.black, fontSize: 13.0),
                              )
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 3,
                          margin: index == 0
                            ? EdgeInsets.only(left: 15.0, top: 13.0, bottom: 13.0)
                            : EdgeInsets.only(left: 15.0, right: index == productCategories.length ? 15.0 : 0.0, top: 13.0, bottom: 13.0),
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        ),
      ),
    );
  }

  void _onSelected(BuildContext context, int idxSelected, int idxProductCategory) async {
    StoreProductCategoryModel storeProductCategoryModel = Provider.of<StoreProductCategoryModel>(context, listen: false)
    ..changeIdxSelectedCategory(idxSelected);
    ProductSummaryModel productSummaryModel = Provider.of<ProductSummaryModel>(context, listen: false)
    ..clear();

    DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
    int dIdx = deliverySiteModel.userDeliverySite?.idx;

    if(idxProductCategory == null) {
      storeProductCategoryModel.idxProductCategory = 0;
      productSummaryModel.clear();
      await productSummaryModel.fetch(
        isForceUpdate: true,
        dIdx: dIdx,
        sIdx: sIdx,
      );
    } else {
      storeProductCategoryModel.idxProductCategory = idxProductCategory;
      productSummaryModel.clear();
      await productSummaryModel.fetch(
        isForceUpdate: true,
        dIdx: dIdx,
        sIdx: sIdx,
        cIdx: idxProductCategory
      );
    }
    this.onChangedCategory();
  }

  Widget _shimmer() => Padding(
    padding: const EdgeInsets.only(left: 15, top: 13, bottom: 13),
    child: CustomShimmer(width: 70),
  );
}
