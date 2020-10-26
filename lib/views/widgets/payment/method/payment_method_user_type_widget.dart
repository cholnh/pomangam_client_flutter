import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'package:pomangam_client_flutter/domains/payment/payment_type.dart';

class PaymentMethodUserTypeWidget extends StatelessWidget {

  final bool isFirst;
  final String bankName;
  final String bankNumberPreview;
  final Function onSelected;
  final bool isSelected;
  final PaymentType paymentType;

  PaymentMethodUserTypeWidget({this.isFirst = false, this.bankName, this.bankNumberPreview, this.onSelected, this.isSelected, this.paymentType});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            isFirst ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(height: 5, thickness: 0.5),
            ) : Container(),
            Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
                leading: Radio(value: isSelected, groupValue: true),
                title:  Text(
                  '$bankName (${convertPaymentTypeToText(paymentType)})',
                  style: TextStyle(fontSize: 14.0, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: Theme.of(context).textTheme.headline1.color)
                ),
                subtitle: Text('$bankNumberPreview', style: TextStyle(fontSize: 12.0, color: Colors.black.withOpacity(0.5))),
              ),
              secondaryActions: <Widget>[
                IconSlideAction(
                  iconWidget: Text('삭제', style: TextStyle(fontSize: 14.0, color: Theme.of(Get.context).backgroundColor)),
                  color: Theme.of(Get.context).primaryColor,
                  onTap: () => print('Delete'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(height: 5, thickness: 0.5),
            )
          ],
        ),
      ),
    );
  }
}
