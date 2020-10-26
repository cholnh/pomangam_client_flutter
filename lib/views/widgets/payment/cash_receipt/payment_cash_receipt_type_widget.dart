import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/domains/payment/cash_receipt/cash_receipt_type.dart';

class PaymentCashReceiptTypeWidget extends StatelessWidget {

  final Function onSelected;
  final bool isIssueCashReceipt;
  final CashReceiptType cashReceiptType;

  PaymentCashReceiptTypeWidget({
    this.onSelected,
    this.isIssueCashReceipt,
    this.cashReceiptType
  });

  @override
  Widget build(BuildContext context) {
    if(isIssueCashReceipt) {
      return GestureDetector(
        onTap: onSelected,
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('종류', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.headline1.color)),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text('${convertCashReceiptTypeToText(cashReceiptType)}', style: TextStyle(fontSize: 14.0, color: Theme.of(context).textTheme.headline1.color)),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ],
              ),
              Divider(height: 10.0)
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
