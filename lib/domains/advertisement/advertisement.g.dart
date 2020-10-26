// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertisement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Advertisement _$AdvertisementFromJson(Map<String, dynamic> json) {
  return Advertisement(
    advertisementType: _$enumDecodeNullable(
        _$AdvertisementTypeEnumMap, json['advertisementType']),
    imagePath: json['imagePath'] as String,
    nextLocation: json['nextLocation'] as String,
    sequence: json['sequence'] as int,
  )
    ..idx = json['idx'] as int
    ..registerDate = json['registerDate'] == null
        ? null
        : DateTime.parse(json['registerDate'] as String)
    ..modifyDate = json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String);
}

Map<String, dynamic> _$AdvertisementToJson(Advertisement instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'registerDate': instance.registerDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'advertisementType':
          _$AdvertisementTypeEnumMap[instance.advertisementType],
      'imagePath': instance.imagePath,
      'nextLocation': instance.nextLocation,
      'sequence': instance.sequence,
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

const _$AdvertisementTypeEnumMap = {
  AdvertisementType.MAIN: 'MAIN',
};
