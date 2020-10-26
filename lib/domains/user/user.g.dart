// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    idx: json['idx'] as int,
    registerDate: json['registerDate'] == null
        ? null
        : DateTime.parse(json['registerDate'] as String),
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
    deliveryDetailSite: json['deliveryDetailSite'] == null
        ? null
        : DeliveryDetailSite.fromJson(
            json['deliveryDetailSite'] as Map<String, dynamic>),
    phoneNumber: json['phoneNumber'] as String,
    password: json['password'] as String,
    name: json['name'] as String,
    nickname: json['nickname'] as String,
    sex: _$enumDecodeNullable(_$SexEnumMap, json['sex']),
    birth:
        json['birth'] == null ? null : DateTime.parse(json['birth'] as String),
    userPointRank: json['userPointRank'] == null
        ? null
        : PointRank.fromJson(json['userPointRank'] as Map<String, dynamic>),
    userPoint: json['userPoint'] as int,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'idx': instance.idx,
      'registerDate': instance.registerDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'deliveryDetailSite': instance.deliveryDetailSite?.toJson(),
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'name': instance.name,
      'nickname': instance.nickname,
      'sex': _$SexEnumMap[instance.sex],
      'birth': instance.birth?.toIso8601String(),
      'userPointRank': instance.userPointRank?.toJson(),
      'userPoint': instance.userPoint,
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

const _$SexEnumMap = {
  Sex.MALE: 'MALE',
  Sex.FEMALE: 'FEMALE',
};
