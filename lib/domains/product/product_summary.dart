import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client_flutter/domains/product/product_type.dart';

part 'product_summary.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class ProductSummary {

  int idx;

  int salePrice;

  String name;

  String productImageMainPath;

  ProductType productType;

  bool isTempActive;

  ProductSummary({this.idx, this.salePrice, this.name, this.productImageMainPath, this.productType, this.isTempActive});

  factory ProductSummary.fromJson(Map<String, dynamic> json) => _$ProductSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$ProductSummaryToJson(this);
  static List<ProductSummary> fromJsonList(List<dynamic> jsonList) {
    List<ProductSummary> entities = [];
    jsonList.forEach((map) => entities.add(ProductSummary.fromJson(map)));
    return entities;
  }
}