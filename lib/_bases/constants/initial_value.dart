import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:pomangam_client_flutter/domains/payment/cash_receipt/cash_receipt_type.dart';
import 'package:pomangam_client_flutter/domains/payment/payment_type.dart';

/// payment
bool initialIsPaymentAgree = false;

/// cash receipt
bool initialIsIssueCashReceipt = false;
CashReceiptType initialCashReceiptType = CashReceiptType.PERSONAL_CARD_NUMBER;

Future<String> getDeviceDetailsTempToken() async {
  String deviceName;
  String deviceVersion;
  String identifier;
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      deviceName = build.model;
      deviceVersion = build.version.toString();
      identifier = build.androidId;  //UUID for Android
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      deviceName = data.name;
      deviceVersion = data.systemVersion;
      identifier = data.identifierForVendor;  //UUID for iOS
    }
  } on PlatformException {
    return 'TEMP-${deviceInfoPlugin.hashCode}';
  }
  return 'TEMP-$deviceName-$deviceVersion-$identifier';
}