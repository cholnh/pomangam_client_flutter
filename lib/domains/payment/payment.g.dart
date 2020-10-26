// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return Payment(
    paymentType:
        _$enumDecodeNullable(_$PaymentTypeEnumMap, json['paymentType']),
    cashReceipt: json['cashReceipt'] == null
        ? null
        : CashReceipt.fromJson(json['cashReceipt'] as Map<String, dynamic>),
    isPaymentAgree: json['isPaymentAgree'] as bool,
    paymentAgreeDate: json['paymentAgreeDate'] == null
        ? null
        : DateTime.parse(json['paymentAgreeDate'] as String),
  );
}

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'paymentType': _$PaymentTypeEnumMap[instance.paymentType],
      'cashReceipt': instance.cashReceipt?.toJson(),
      'isPaymentAgree': instance.isPaymentAgree,
      'paymentAgreeDate': instance.paymentAgreeDate?.toIso8601String(),
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

const _$PaymentTypeEnumMap = {
  PaymentType.CONTACT_CREDIT_CARD: 'CONTACT_CREDIT_CARD',
  PaymentType.CONTACT_CASH: 'CONTACT_CASH',
  PaymentType.COMMON_CREDIT_CARD: 'COMMON_CREDIT_CARD',
  PaymentType.COMMON_PHONE: 'COMMON_PHONE',
  PaymentType.COMMON_V_BANK: 'COMMON_V_BANK',
  PaymentType.COMMON_BANK: 'COMMON_BANK',
};
