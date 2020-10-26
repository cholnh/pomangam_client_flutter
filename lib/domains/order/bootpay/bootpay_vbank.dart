import 'package:json_annotation/json_annotation.dart';

part 'bootpay_vbank.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class BootpayVbank {

  int idxOrder;
  String vbankName;
  String vbankAccount;
  int vbankPrice;

  BootpayVbank({
    this.idxOrder,
    this.vbankName,
    this.vbankAccount,
    this.vbankPrice
  });

  factory BootpayVbank.fromJson(Map<String, dynamic> json) => _$BootpayVbankFromJson(json);
  Map<String, dynamic> toJson() => _$BootpayVbankToJson(this);
}