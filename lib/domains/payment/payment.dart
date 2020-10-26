import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client_flutter/_bases/constants/initial_value.dart';
import 'package:pomangam_client_flutter/domains/payment/cash_receipt/cash_receipt.dart';
import 'package:pomangam_client_flutter/domains/payment/payment_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomangam_client_flutter/_bases/key/shared_preference_key.dart' as s;

import 'cash_receipt/cash_receipt_type.dart';

part 'payment.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class Payment {

  PaymentType paymentType;

  CashReceipt cashReceipt;

  bool isPaymentAgree;

  DateTime paymentAgreeDate;

  String vbankName;

  Payment({
    this.paymentType,
    this.cashReceipt,
    this.isPaymentAgree,
    this.paymentAgreeDate,
    this.vbankName
  });

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);

  Future<void> loadPayment() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    paymentType = convertTextToPaymentType(pref.getString(s.paymentType));
    if(cashReceipt == null) {
      cashReceipt = CashReceipt();
    }
    cashReceipt.isIssueCashReceipt = pref.getBool(s.isIssueCashReceipt) ?? initialIsIssueCashReceipt;
    cashReceipt.cashReceiptNumber = pref.getString(s.cashReceiptNumber);
    cashReceipt.cashReceiptType = pref.getString(s.cashReceiptType) != null ? convertTextToCashReceiptType(pref.getString(s.cashReceiptType)) : initialCashReceiptType;
    isPaymentAgree = pref.getBool(s.isPaymentAgree) ?? initialIsPaymentAgree;
    paymentAgreeDate = pref.getString(s.paymentAgreeDate) != null ? DateTime.parse(pref.getString(s.paymentAgreeDate)) : null;
    vbankName = pref.getString(s.vbankName);
  }

  bool isReadyPayment() {
    return paymentType != null;
  }

  Future<void> savePaymentType(PaymentType paymentType) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(s.paymentType, paymentType.toString());
    this.paymentType = paymentType;
  }

  Future<void> saveIsIssueCashReceipt(bool isIssueCashReceipt) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(s.isIssueCashReceipt, isIssueCashReceipt);
    this.cashReceipt.isIssueCashReceipt = isIssueCashReceipt;
  }

  Future<void> saveCashReceiptNumber(String cashReceiptNumber) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(s.cashReceiptNumber, cashReceiptNumber);
    this.cashReceipt.cashReceiptNumber = cashReceiptNumber;
  }

  Future<void> saveCashReceiptType(CashReceiptType cashReceiptType) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(s.cashReceiptType, cashReceiptType.toString());
    this.cashReceipt.cashReceiptType = cashReceiptType;
  }

  Future<void> saveIsPaymentAgree(bool isPaymentAgree) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(s.isPaymentAgree, isPaymentAgree);
    this.isPaymentAgree = isPaymentAgree;
  }

  Future<void> savePaymentAgreeDate(DateTime paymentAgreeDate) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(s.paymentAgreeDate, paymentAgreeDate?.toIso8601String());
    this.paymentAgreeDate = paymentAgreeDate;
  }

  Future<void> saveVBankName(String vbankName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(s.vbankName, vbankName);
    this.vbankName = vbankName;
  }
}