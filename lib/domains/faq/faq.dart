import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client_flutter/domains/_bases/entity_auditing.dart';

part 'faq.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class Faq extends EntityAuditing {

  String title;
  String contents;

  Faq({
    int idx, DateTime registerDate, DateTime modifyDate,
    this.title, this.contents
  }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

  factory Faq.fromJson(Map<String, dynamic> json) => _$FaqFromJson(json);
  Map<String, dynamic> toJson() => _$FaqToJson(this);
  static List<Faq> fromJsonList(List<dynamic> jsonList) {
    List<Faq> entities = [];
    jsonList.forEach((map) => entities.add(Faq.fromJson(map)));
    return entities;
  }
}