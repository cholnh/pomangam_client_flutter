import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/views/widgets/product/custom/product_custom_image_part_widget.dart';
import 'package:provider/provider.dart';
import 'package:pomangam_client_flutter/domains/product/sub/category/product_sub_category.dart';
import 'package:pomangam_client_flutter/providers/product/sub/product_sub_category_model.dart';

class ProductCustom3ImageWidget extends StatelessWidget {

  final Function(int) onSelected;

  ProductCustom3ImageWidget({this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductSubCategoryModel>(
      builder: (_, categoryModel, child) {
        int selected = categoryModel.idxSelectedCategory;
        return Consumer<ProductModel>(
          builder: (_, productModel, child) {
            List<ProductSubCategory> subCategories = productModel.product?.productSubCategories;

            if(subCategories.length != 3) {
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
              padding: EdgeInsets.only(left: 60.0, right: 60.0, bottom: 10.0, top: 10.0),
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
                          child: ProductCustomImagePartWidget(
                            height: 80,
                            isSelected: selected == subCategories[1].idx,
                            category: subCategories[1],
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                            ),
                            onTap: () => _changeCategory(subCategories[1].idx),
                          )
                        ),
                        Expanded(
                          child: ProductCustomImagePartWidget(
                            height: 80,
                            isSelected: selected == subCategories[2].idx,
                            category: subCategories[2],
                            borderRadius: BorderRadius.only(
                              topRight: const Radius.circular(10.0),
                            ),
                            onTap: () => _changeCategory(subCategories[2].idx),
                          )
                        )
                      ],
                    ),
                    ProductCustomImagePartWidget(
                      height: 80,
                      isSelected: selected == subCategories[0].idx,
                      category: subCategories[0],
                      borderRadius: BorderRadius.only(
                        bottomRight: const Radius.circular(10.0),
                        bottomLeft: const Radius.circular(10.0),
                      ),
                      onTap: () => _changeCategory(subCategories[0].idx),
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

  void _changeCategory(int idxProductSubCategory) {
    this.onSelected(idxProductSubCategory);
  }
}
