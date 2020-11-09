import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/domains/product/sub/category/product_sub_category.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

class ProductCustomSub2Widget extends StatefulWidget {

  final PageController pageController;

  ProductCustomSub2Widget({this.pageController});

  @override
  _ProductCustomSub2WidgetState createState() => _ProductCustomSub2WidgetState();
}

class _ProductCustomSub2WidgetState extends State<ProductCustomSub2Widget> {

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<ProductModel>(
        builder: (_, model, child) {
          if(model.product?.productSubCategories == null || model.product.productSubCategories.isEmpty) {
            return  Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: model.isProductFetching
                  ? CupertinoActivityIndicator()
                  : Text('메뉴가 없습니다.', style: TextStyle(color: Colors.grey, fontSize: 14)),
              ),
            );
          }
          double height = MediaQuery.of(context).size.height - 160 - 8 - 56 - 45;
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[300],
                  width: 1
                )
              )
            ),
            height: height,
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    physics: BouncingScrollPhysics(),
                    children: _subItems(model.product.productSubCategories, model.idxProductSubCategory),
                    controller: widget.pageController,
                  )
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: ScrollingPageIndicator(
                      dotColor: Colors.black12,
                      dotSelectedColor: Theme.of(Get.context).primaryColor,
                      dotSize: 5,
                      dotSelectedSize: 6,
                      dotSpacing: 9,
                      controller: widget.pageController,
                      itemCount: _count(model.product.productSubCategories, model.idxProductSubCategory),
                      orientation: Axis.horizontal
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: Theme.of(context).primaryColor,
                  child: Center(
                    child: Text('선택', style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    )),
                  ),
                )
              ],
            )
          );
        }
      ),
    );
  }

  int _count(List<ProductSubCategory> subCategories, int idxProductSubCategory) {
    int count = 0;
    subCategories.forEach((category) {
      if(idxProductSubCategory == 0 || idxProductSubCategory == category.idx) {
        count += category.productSubs.length;
      }
    });
    return count;
  }

  List<Widget> _subItems(List<ProductSubCategory> subCategories, int idxProductSubCategory) {
    List<Widget> widgets = List();
    subCategories.forEach((category) {
      if(idxProductSubCategory == 0 || idxProductSubCategory == category.idx) {
        category.productSubs.forEach((sub) {
          widgets.add(GestureDetector(
            onTap: () {
              context.read<ProductModel>().toggleProductSubIsSelected(
                productSubCategory: category,
                subIdx: sub.idx,
                isRadio: true
              );
            },
            child: Container(
                width: MediaQuery.of(Get.context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            Text('${sub.productSubInfo.name}', style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            )),
                            SizedBox(height: 3),
                            Text('${sub.productSubInfo.description}', style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).textTheme.subtitle2.color
                            )),
                          ],
                        ),
                        if(sub.salePrice != 0) Align(
                          alignment: Alignment.centerRight,
                          child: Text('+${StringUtils.comma(sub.salePrice)}원', style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).primaryColor
                          )),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            imageUrl: '${Endpoint.serverDomain}/${sub.productImageMainPath}?v=${sub.modifyDate}',
                            fit: BoxFit.fill,
                            width: MediaQuery.of(Get.context).size.width,
                            placeholder: (_, __) => CustomShimmer(
                                width: MediaQuery.of(Get.context).size.width,
                                borderRadius: BorderRadius.zero
                            ),
                            errorWidget: (context, error, stackTrace) => Icon(Icons.error_outline)
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: _fullScreen,
                              child: Material(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Icon(
                                      Icons.fullscreen,
                                      color: Colors.white,
                                      size: 20.0
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
            )
          ));
        });
      }
    });
    return widgets;
  }

  void _fullScreen() {

  }
}