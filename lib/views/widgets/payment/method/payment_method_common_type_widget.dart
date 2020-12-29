import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/domains/payment/payment_type.dart';

class PaymentMethodCommonTypeWidget extends StatelessWidget {

  final bool isFirst;
  final Function onSelected;
  final bool isSelected;
  final PaymentType paymentType;
  final bool isActive;
  final String subtitle;

  PaymentMethodCommonTypeWidget({this.isFirst = false, this.onSelected, this.isSelected, this.paymentType, this.isActive = true, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onSelected : (){},
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            isFirst ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(height: 5, thickness: 0.5),
            ) : Container(),
            Opacity(
              opacity: isActive ? 1.0 : 0.5,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
                leading: Radio(value: isSelected, groupValue: true),
                title:  Text(
                  '${convertPaymentTypeToText(paymentType)}',
                  style: TextStyle(fontSize: 14.0, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: Theme.of(context).textTheme.headline1.color)
                ),
                subtitle: subtitle == null ? null : Text('$subtitle', style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.headline1.color
                )),
              ),
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
