import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pomangam_client_flutter/domains/order/order_response.dart';
import 'package:pomangam_client_flutter/providers/order/order_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/bottom_button.dart';
import 'package:pomangam_client_flutter/views/widgets/order/order_success/order_success_receipt_widget.dart';

class OrderSuccessPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    OrderResponse response = context.watch<OrderModel>().orderResponse;
    return Scaffold(
      appBar: BasicAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Icon(CupertinoIcons.check_mark_circled,
                      size: 50,
                      color: Theme.of(context).primaryColor
                  ),
                  SizedBox(height: 15),
                  Text('주문이 완료되었습니다.', style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).textTheme.headline1.color
                  )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Divider(height: 2.5, thickness: 1.0, color: Colors.grey[200]),
                        Divider(height: 2.5, thickness: 1.0, color: Colors.grey[200]),
                        SizedBox(height: 30),
                        _text(
                            left: '식별번호',
                            right: '${response.boxNumber}번'
                        ),
                        SizedBox(height: 15),
                        _text(
                            left: '승인일시',
                            right: '${_date(response.registerDate)}'
                        ),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () => _receiptTap(response),
                          child: Container(
                            width: 150,
                            height: 45,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).dividerColor,
                                    width: 1.0
                                )
                            ),
                            child: Center(
                              child: Text('영수증 보기', style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context).textTheme.headline1.color
                              )),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Divider(height: 2.5, thickness: 1.0, color: Colors.grey[200]),
                        Divider(height: 2.5, thickness: 1.0, color: Colors.grey[200]),
                      ],
                    ),
                  )
                ],
              ),
            ),
            BottomButton(
              text: '홈으로',
              onTap: () => Get.back(),
            )
          ],
        ),
      ),
    );
  }

  void _receiptTap(OrderResponse response) {
    showDialog(
      context: Get.context,
      barrierDismissible: true,
      builder: (dialogContext) => Dialog(
        insetPadding: const EdgeInsets.all(15),
        child: Material(
          color: Theme.of(Get.context).backgroundColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10.0, bottom: 30),
            child: OrderSuccessReceiptWidget(response: response)
          )
        )
      )
    );
  }

  Widget _text({
    String left,
    String right,
    double fontSize = 15,
    FontWeight leftFontWeight = FontWeight.normal,
    FontWeight rightFontWeight = FontWeight.bold
  }) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left, style: TextStyle(
              fontSize: fontSize,
              color: Theme.of(Get.context).textTheme.bodyText2.color,
              fontWeight: leftFontWeight
          )),
          Text(right, style: TextStyle(
              fontSize: fontSize,
              color: Theme.of(Get.context).textTheme.headline1.color,
              fontWeight: rightFontWeight
          ))
        ]
    );
  }

  String _date(DateTime dt) {
    return DateFormat('yyyy. MM. dd hh:mm:ss').format(dt);
  }
}
