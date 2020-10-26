// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderTime _$OrderTimeFromJson(Map<String, dynamic> json) {
  return OrderTime(
    idx: json['idx'] as int,
    registerDate: json['registerDate'] == null
        ? null
        : DateTime.parse(json['registerDate'] as String),
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
    arrivalTime: json['arrivalTime'] as String,
    pickUpTime: json['pickUpTime'] as String,
    orderEndTime: json['orderEndTime'] as String,
  );
}

Map<String, dynamic> _$OrderTimeToJson(OrderTime instance) => <String, dynamic>{
      'idx': instance.idx,
      'registerDate': instance.registerDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'arrivalTime': instance.arrivalTime,
      'pickUpTime': instance.pickUpTime,
      'orderEndTime': instance.orderEndTime,
    };
