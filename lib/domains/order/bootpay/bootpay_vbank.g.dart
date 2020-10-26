// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bootpay_vbank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BootpayVbank _$BootpayVbankFromJson(Map<String, dynamic> json) {
  return BootpayVbank(
    idxOrder: json['idxOrder'] as int,
    vbankName: json['vbankName'] as String,
    vbankAccount: json['vbankAccount'] as String,
    vbankPrice: json['vbankPrice'] as int,
  );
}

Map<String, dynamic> _$BootpayVbankToJson(BootpayVbank instance) =>
    <String, dynamic>{
      'idxOrder': instance.idxOrder,
      'vbankName': instance.vbankName,
      'vbankAccount': instance.vbankAccount,
      'vbankPrice': instance.vbankPrice,
    };
