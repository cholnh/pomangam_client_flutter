// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashReceipt _$CashReceiptFromJson(Map<String, dynamic> json) {
  return CashReceipt(
    cashReceiptNumber: json['cashReceiptNumber'] as String,
    cashReceiptType:
        _$enumDecodeNullable(_$CashReceiptTypeEnumMap, json['cashReceiptType']),
  )..isIssueCashReceipt = json['isIssueCashReceipt'] as bool;
}

Map<String, dynamic> _$CashReceiptToJson(CashReceipt instance) =>
    <String, dynamic>{
      'isIssueCashReceipt': instance.isIssueCashReceipt,
      'cashReceiptNumber': instance.cashReceiptNumber,
      'cashReceiptType': _$CashReceiptTypeEnumMap[instance.cashReceiptType],
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

const _$CashReceiptTypeEnumMap = {
  CashReceiptType.PERSONAL_PHONE_NUMBER: 'PERSONAL_PHONE_NUMBER',
  CashReceiptType.PERSONAL_CARD_NUMBER: 'PERSONAL_CARD_NUMBER',
  CashReceiptType.BUSINESS_REGISTRATION_NUMBER: 'BUSINESS_REGISTRATION_NUMBER',
  CashReceiptType.BUSINESS_CARD_NUMBER: 'BUSINESS_CARD_NUMBER',
};
