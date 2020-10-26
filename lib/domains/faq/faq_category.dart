import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client_flutter/domains/_bases/entity_auditing.dart';
import 'package:pomangam_client_flutter/domains/faq/faq.dart';

part 'faq_category.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class FaqCategory extends EntityAuditing {

  String title;
  List<Faq> faqs = List();

  FaqCategory({
    int idx, DateTime registerDate, DateTime modifyDate,
    this.title, this.faqs
  }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

  factory FaqCategory.fromJson(Map<String, dynamic> json) => _$FaqCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$FaqCategoryToJson(this);
  static List<FaqCategory> fromJsonList(List<dynamic> jsonList) {
    List<FaqCategory> entities = [];
    jsonList.forEach((map) => entities.add(FaqCategory.fromJson(map)));
    return entities;
  }
}