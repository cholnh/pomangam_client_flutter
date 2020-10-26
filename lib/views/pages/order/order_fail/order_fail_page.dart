import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/domains/order/order_response.dart';
import 'package:pomangam_client_flutter/providers/order/order_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/bottom_button.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderFailPage extends StatelessWidget {

  final String reason;

  OrderFailPage({this.reason});

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
                  Icon(CupertinoIcons.minus_circled,
                      size: 50,
                      color: Theme.of(context).primaryColor
                  ),
                  SizedBox(height: 15),
                  Text('주문 처리에 실패했습니다.', style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).textTheme.headline1.color
                  )),
                  SizedBox(height: 10),
                  Text('이용에 불편을 드려 죄송합니다', style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).textTheme.headline3.color
                  )),
                  Text('아래 버튼 클릭시 메인으로 이동합니다', style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).textTheme.headline3.color
                  )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Divider(height: 2.5, thickness: 1.0, color: Colors.grey[200]),
                        Divider(height: 2.5, thickness: 1.0, color: Colors.grey[200]),
                        SizedBox(height: 30),
                        _text(
                            left: '오류번호',
                            right: 'no.${response.idx.toString()}'
                        ),
                        SizedBox(height: 15),
                        _text(
                            left: '사유',
                            right: '$reason'
                        ),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: _contactCustomerServiceCenter,
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
                              child: Text('문의하기', style: TextStyle(
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

  Widget _text({String left, String right}) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(left, style: TextStyle(
              fontSize: 15,
              color: Theme.of(Get.context).textTheme.headline3.color
          )),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              child: Text(right, style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(Get.context).textTheme.bodyText2.color,
                  fontWeight: FontWeight.bold
              ), textAlign: TextAlign.end, maxLines: 5, overflow: TextOverflow.ellipsis),
            ),
          )
        ]
    );
  }

  void _contactCustomerServiceCenter() {
    DialogUtils.dialogYesOrNo(Get.context, '고객센터로 전화연결합니다',
        onConfirm: (_) async {
          String tel = 'tel:${Endpoint.customerServiceCenterNumber}';
          if (await canLaunch(tel)) {
            await launch(tel);
          } else {
            throw 'Could not launch $tel';
          }
        }
    );
  }
}

