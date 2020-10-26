// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointLog _$PointLogFromJson(Map<String, dynamic> json) {
  return PointLog(
    idx: json['idx'] as int,
    idxOrder: json['idxOrder'] as int,
    idxUser: json['idxUser'] as int,
    pointType: _$enumDecodeNullable(_$PointTypeEnumMap, json['pointType']),
    point: json['point'] as int,
    postPoint: json['postPoint'] as int,
    registerDate: json['registerDate'] == null
        ? null
        : DateTime.parse(json['registerDate'] as String),
    expiredDate: json['expiredDate'] == null
        ? null
        : DateTime.parse(json['expiredDate'] as String),
  );
}

Map<String, dynamic> _$PointLogToJson(PointLog instance) => <String, dynamic>{
      'idx': instance.idx,
      'idxOrder': instance.idxOrder,
      'idxUser': instance.idxUser,
      'pointType': _$PointTypeEnumMap[instance.pointType],
      'point': instance.point,
      'postPoint': instance.postPoint,
      'registerDate': instance.registerDate?.toIso8601String(),
      'expiredDate': instance.expiredDate?.toIso8601String(),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$PointTypeEnumMap = {
  PointType.ISSUED_BY_PROMOTION: 'ISSUED_BY_PROMOTION',
  PointType.ISSUED_BY_BUY: 'ISSUED_BY_BUY',
  PointType.ROLLBACK_ISSUED_BY_PAYMENT_CANCEL:
      'ROLLBACK_ISSUED_BY_PAYMENT_CANCEL',
  PointType.ROLLBACK_SAVED_BY_PAYMENT_CANCEL:
      'ROLLBACK_SAVED_BY_PAYMENT_CANCEL',
  PointType.USED_BY_BUY: 'USED_BY_BUY',
  PointType.UPDATED_PLUS_BY_ADMIN: 'UPDATED_PLUS_BY_ADMIN',
  PointType.UPDATED_MINUS_BY_ADMIN: 'UPDATED_MINUS_BY_ADMIN',
};
