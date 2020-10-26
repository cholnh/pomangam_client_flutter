// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductionInfo _$ProductionInfoFromJson(Map<String, dynamic> json) {
  return ProductionInfo(
    minimumTime: json['minimumTime'] as int,
    parallelProduction: json['parallelProduction'] as int,
    maximumProduction: json['maximumProduction'] as int,
  );
}

Map<String, dynamic> _$ProductionInfoToJson(ProductionInfo instance) =>
    <String, dynamic>{
      'minimumTime': instance.minimumTime,
      'parallelProduction': instance.parallelProduction,
      'maximumProduction': instance.maximumProduction,
    };
