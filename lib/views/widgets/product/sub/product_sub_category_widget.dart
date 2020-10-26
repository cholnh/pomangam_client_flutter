import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/domains/product/sub/category/product_sub_category.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/providers/product/sub/product_sub_category_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:provider/provider.dart';

class ProductSubCategoryWidget extends StatelessWidget {

  final Function(int, int) onSelected;
  final GlobalKey keyProductSubCategory;
  final ScrollController scrollController = ScrollController();

  ProductSubCategoryWidget({this.keyProductSubCategory, this.onSelected}) {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      int selected = Get.context.read<ProductSubCategoryModel>().idxSelectedCategory;
      int to = (selected < 4 ? 0 : selected) * 20;
      scrollController.animateTo(
          to.toDouble(),
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInQuart
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      key: keyProductSubCategory,
      backgroundColor: Theme.of(Get.context).backgroundColor,
      floating: true,
      pinned: true,
      centerTitle: false,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0.3,
      title: Container(
        height: 60,
        child: Consumer<ProductSubCategoryModel>(
          builder: (_, categoryModel, child) {
            int selected = categoryModel.idxSelectedCategory;
            return Consumer<ProductModel>(
              builder: (_, productModel, child) {
                List<ProductSubCategory> subCategories = productModel?.product?.productSubCategories;
                int count = productModel.isProductFetching ? 5 : (subCategories == null ? 0 : subCategories.length+1);

                return ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: count,
                  itemBuilder: (context, index) {
                    if(productModel.isProductFetching) {
                      return _shimmer();
                    } else {
                      return GestureDetector(
                        onTap: index == 0
                            ? () => _onSelected(index, null)
                            : () => _onSelected(index, subCategories[index-1].idx),
                        child: Card(
                          semanticContainer: true,
                          color: index == selected ? Theme.of(context).primaryColor : Theme.of(context).backgroundColor,
                          child: Container(
                              margin: EdgeInsets.only(left: 15.0, right: 15.0),
                              padding: EdgeInsets.all(5.0),
                              alignment: Alignment.center,
                              child: Text(index == 0
                                  ? '전체'
                                  : '${subCategories[index-1].categoryTitle}',
                                style: TextStyle(color: index == selected ? Colors.white : Colors.black, fontSize: 13.0),
                              )
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 2,
                          shadowColor: Theme.of(context).backgroundColor,
                          margin: index == 0
                              ? EdgeInsets.only(left: 15.0, top: 13.0, bottom: 13.0)
                              : EdgeInsets.only(left: 15.0, right: index == subCategories.length ? 15.0 : 0.0, top: 13.0, bottom: 13.0),
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

  Widget _shimmer() => Padding(
    padding: const EdgeInsets.only(left: 15, top: 13, bottom: 13),
    child: CustomShimmer(width: 70),
  );


  void _onSelected(int idxSelected, int idxProductSubCategory) {
    this.onSelected(idxSelected, idxProductSubCategory);
  }
}
