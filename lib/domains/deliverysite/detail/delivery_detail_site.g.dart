// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_detail_site.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryDetailSite _$DeliveryDetailSiteFromJson(Map<String, dynamic> json) {
  return DeliveryDetailSite(
    idx: json['idx'] as int,
    registerDate: json['registerDate'] == null
        ? null
        : DateTime.parse(json['registerDate'] as String),
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
    idxDeliverySite: json['idxDeliverySite'] as int,
    name: json['name'] as String,
    location: json['location'] as String,
    sequence: json['sequence'] as int,
    additionalTime: json['additionalTime'] as String,
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    abbreviation: json['abbreviation'] as String,
  );
}

Map<String, dynamic> _$DeliveryDetailSiteToJson(DeliveryDetailSite instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'registerDate': instance.registerDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'idxDeliverySite': instance.idxDeliverySite,
      'name': instance.name,
      'location': instance.location,
      'sequence': instance.sequence,
      'additionalTime': instance.additionalTime,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'abbreviation': instance.abbreviation,
    };
