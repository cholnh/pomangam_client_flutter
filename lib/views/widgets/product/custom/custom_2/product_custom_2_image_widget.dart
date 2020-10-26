import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/domains/product/sub/category/product_sub_category.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/providers/product/sub/product_sub_category_model.dart';
import 'package:provider/provider.dart';
import 'package:pomangam_client_flutter/views/widgets/product/custom/custom_2/product_custom_2_image_part_widget.dart';

class ProductCustom2ImageWidget extends StatelessWidget {

  final Function(int, int) onSelected;

  ProductCustom2ImageWidget({this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductSubCategoryModel>(
      builder: (_, categoryModel, child) {
        int selected = categoryModel.idxSelectedCategory;

        return Consumer<ProductModel>(
          builder: (_, productModel, child) {
            List<ProductSubCategory> subCategories = productModel.product?.productSubCategories;

            if(subCategories.length != 2) {
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
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ProductCustom2ImagePartWidget(
                        isSelected: selected == 1,
                        category: subCategories[0],
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(10.0),
                          bottomLeft: const Radius.circular(10.0)
                        ),
                        onTap: () => _changeCategory(1, subCategories[0].idx),
                      )
                    ),
                    Expanded(
                      child: ProductCustom2ImagePartWidget(
                        isSelected: selected == 2,
                        category: subCategories[1],
                        borderRadius: BorderRadius.only(
                            topRight: const Radius.circular(10.0),
                            bottomRight: const Radius.circular(10.0)
                        ),
                        onTap: () => _changeCategory(2, subCategories[1].idx),
                      )
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
