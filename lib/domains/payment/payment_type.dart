import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

enum PaymentType {
  CONTACT_CREDIT_CARD,
  CONTACT_CASH,

  COMMON_CREDIT_CARD,
  COMMON_PHONE,
  COMMON_V_BANK,
  COMMON_BANK,
  //COMMON_KAKAOPAY,
  //COMMON_REMOTE_PAY,

  //PERIODIC_CREDIT_CARD,
  //PERIODIC_FIRM_BANK,
}

PaymentType convertTextToPaymentType(String type) {
  if(type == null) return null;
  return PaymentType.values.singleWhere((value) => value.toString().toUpperCase() == type.toUpperCase());
}

String convertPaymentTypeToText(PaymentType type) {
  if(type != null) {
    switch(type) {
      case PaymentType.CONTACT_CREDIT_CARD:
        return '만나서 카드 결제';
      case PaymentType.CONTACT_CASH:
        return '만나서 현금 결제';
      case PaymentType.COMMON_CREDIT_CARD:
        return '신용/체크 카드';
      case PaymentType.COMMON_PHONE:
        return '핸드폰 결제';
      case PaymentType.COMMON_V_BANK:
        return '무통장 입금';
      case PaymentType.COMMON_BANK:
        return '실시간 계좌이체';
//      case PaymentType.COMMON_KAKAOPAY:
//        return '카카오페이';
//      case PaymentType.COMMON_REMOTE_PAY:
//        return '밥은 내가 고를게, 돈은 누가 낼래?';
//      case PaymentType.PERIODIC_CREDIT_CARD:
//        return '신용/체크 카드';
//      case PaymentType.PERIODIC_FIRM_BANK:
//        return '계좌이체';
    }
  }
  return '결제수단 미등록';
}

Widget convertPaymentTypeToIcon(PaymentType type) {
  if(type != null) {
    switch(type) {
      case PaymentType.CONTACT_CREDIT_CARD:
        return Icon(Icons.credit_card, size: 14.0);
      case PaymentType.CONTACT_CASH:
        return Icon(Icons.monetization_on, size: 14.0);
      case PaymentType.COMMON_CREDIT_CARD:
        return Icon(Icons.credit_card, size: 14.0);
      case PaymentType.COMMON_PHONE:
        return Icon(Icons.phone_iphone, size: 14.0);
      case PaymentType.COMMON_V_BANK:
        return Icon(Icons.format_bold, size: 14.0);
      case PaymentType.COMMON_BANK:
        return Icon(Icons.format_bold, size: 14.0);
//      case PaymentType.COMMON_KAKAOPAY:
//        return Icon(Icons.format_bold, size: 14.0);
//      case PaymentType.COMMON_REMOTE_PAY:
//        return Icon(Icons.insert_emoticon, size: 14.0);
//      case PaymentType.PERIODIC_CREDIT_CARD:
//        return Icon(Icons.credit_card, size: 14.0);
//      case PaymentType.PERIODIC_FIRM_BANK:
//        return Icon(Icons.format_bold, size: 14.0);
    }
  }
  return Icon(Icons.error, size: 16.0, color: Theme.of(Get.context).primaryColor);
}