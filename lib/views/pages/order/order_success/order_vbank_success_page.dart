import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/_bases/util/toast_utils.dart';
import 'package:pomangam_client_flutter/providers/order/order_model.dart';
import 'package:pomangam_client_flutter/views/pages/_bases/base_page.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/bottom_button.dart';
import 'package:provider/provider.dart';

class OrderVBankSuccessPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    OrderModel orderModel = context.watch();
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
                            right: '${orderModel.orderResponse.boxNumber}번'
                        ),
                        SizedBox(height: 15),
                        _text(
                            left: '결제금액',
                            right: '${StringUtils.comma(orderModel.bootpayVbank.vbankPrice)}원'
                        ),
                        SizedBox(height: 15),
                        _text(
                            left: '입금은행',
                            right: '${Endpoint.vbank}'
                        ),
                        SizedBox(height: 15),
                        _text(
                            left: '계좌번호',
                            right: '${Endpoint.vbankAccount} (${Endpoint.vbankOwner})'
                        ),
                        SizedBox(height: 15),
                        Text('입금자명과 금액이 일치하지 않으면 입금 확인이 되지 않습니다.', style: TextStyle(
                          fontSize: 12.0,
                          color: Theme.of(context).primaryColor,
                        )),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: _copy,
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
                              child: Text('계좌정보 복사하기', style: TextStyle(
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
              onTap: () {
                Get.back();
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }

  void _copy() {
    Clipboard.setData(new ClipboardData(text: '${Endpoint.vbank} ${Endpoint.vbankAccount}'));
    ToastUtils.showToast(msg: '복사완료');
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

}
