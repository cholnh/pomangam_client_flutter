// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreSchedule _$StoreScheduleFromJson(Map<String, dynamic> json) {
  return StoreSchedule(
    openTime: json['openTime'] as String,
    closeTime: json['closeTime'] as String,
    isOpening: json['isOpening'] as bool,
    pauseDescription: json['pauseDescription'] as String,
  );
}

Map<String, dynamic> _$StoreScheduleToJson(StoreSchedule instance) =>
    <String, dynamic>{
      'openTime': instance.openTime,
      'closeTime': instance.closeTime,
      'isOpening': instance.isOpening,
      'pauseDescription': instance.pauseDescription,
    };
