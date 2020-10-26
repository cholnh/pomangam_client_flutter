import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:provider/provider.dart';
import 'package:pomangam_client_flutter/domains/product/sub/category/product_sub_category.dart';
import 'package:pomangam_client_flutter/providers/product/sub/product_sub_category_model.dart';
import 'package:pomangam_client_flutter/views/widgets/product/custom/custom_3/product_custom_3_image_part_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/product/custom/custom_4/product_custom_4_image_part_widget.dart';

class ProductCustom4ImageWidget extends StatelessWidget {

  final Function(int, int) onSelected;

  ProductCustom4ImageWidget({this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductSubCategoryModel>(
      builder: (_, categoryModel, child) {
        int selected = categoryModel.idxSelectedCategory;
        return Consumer<ProductModel>(
          builder: (_, productModel, child) {
            List<ProductSubCategory> subCategories = productModel.product?.productSubCategories;

            if(subCategories.length != 4) {
              return Container(
                height: 180,
                child: Center(
                  child: Icon(Icons.error_outline),
                ),
              );
            }

            return Container(
              height: 180,
              margin: EdgeInsets.only(bottom: 0.0),
              padding: EdgeInsets.only(left: 60.0, right: 60.0, bottom: 20.0, top: 20.0),
              color: Color.fromRGBO(0, 0, 0, 0.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(blurRadius: 10),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: ProductCustom4ImagePartWidget(
                            height: 70,
                            isSelected: selected == 2,
                            category: subCategories[1],
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                            ),
                            onTap: () => _changeCategory(2, subCategories[1].idx),
                          )
                        ),
                        Expanded(
                          flex: 1,
                          child: ProductCustom4ImagePartWidget(
                            height: 70,
                            isSelected: selected == 3,
                            category: subCategories[2],
                            onTap: () => _changeCategory(3, subCategories[2].idx),
                          )
                        ),
                        Expanded(
                            flex: 1,
                            child: ProductCustom4ImagePartWidget(
                              height: 70,
                              isSelected: selected == 4,
                              category: subCategories[3],
                              borderRadius: BorderRadius.only(
                                topRight: const Radius.circular(10.0),
                              ),
                              onTap: () => _changeCategory(4, subCategories[3].idx),
                            )
                        )
                      ],
                    ),
                    ProductCustom3ImagePartWidget(
                      height: 70,
                      isSelected: selected == 1,
                      category: subCategories[0],
                      borderRadius: BorderRadius.only(
                        bottomRight: const Radius.circular(10.0),
                        bottomLeft: const Radius.circular(10.0),
                      ),
                      onTap: () => _changeCategory(1, subCategories[0].idx),
                    )
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }

  void _changeCategory(int idxSelected, int idxProductSubCategory) {
    this.onSelected(idxSelected, idxProductSubCategory);
  }
}
