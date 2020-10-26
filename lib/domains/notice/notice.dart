import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client_flutter/domains/_bases/entity_auditing.dart';

part 'notice.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class Notice extends EntityAuditing {

  String title;
  String contents;
  DateTime beginDate;
  DateTime endDate;

  Notice({
    int idx, DateTime registerDate, DateTime modifyDate,
    this.title, this.contents, this.beginDate, this.endDate
  }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

  factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);
  Map<String, dynamic> toJson() => _$NoticeToJson(this);
  static List<Notice> fromJsonList(List<dynamic> jsonList) {
    List<Notice> entities = [];
    jsonList.forEach((map) => entities.add(Notice.fromJson(map)));
    return entities;
  }
}