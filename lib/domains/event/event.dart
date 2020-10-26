import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client_flutter/domains/_bases/entity_auditing.dart';

part 'event.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class Event extends EntityAuditing {

  String title;
  String contents;
  DateTime beginDate;
  DateTime endDate;

  Event({
    int idx, DateTime registerDate, DateTime modifyDate,
    this.title, this.contents, this.beginDate, this.endDate
  }): super(idx: idx, registerDate: registerDate, modifyDate: modifyDate);

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
  static List<Event> fromJsonList(List<dynamic> jsonList) {
    List<Event> entities = [];
    jsonList.forEach((map) => entities.add(Event.fromJson(map)));
    return entities;
  }
}