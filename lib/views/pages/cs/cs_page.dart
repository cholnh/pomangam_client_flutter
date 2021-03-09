import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/views/pages/cs/faq_page.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:pomangam_client_flutter/views/widgets/payment/payment_item_widget.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'dart:html' as html;

class CsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: BasicAppBar(
        title: '고객센터',
        leadingIcon: Icon(CupertinoIcons.back, size: 20, color: Colors.black),
        elevation: 1.0,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            PaymentItemWidget(
              title: '자주 묻는 질문',
              onSelected: () => Get.to(FaqPage(), transition: Transition.cupertino, duration: Duration.zero),
            ),
            PaymentItemWidget(
              title: '카카오톡 문의',
              onSelected: _kakao,
            ),
            PaymentItemWidget(
              title: '상담원 연결',
              onSelected: _phone,
              isLast: true,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('고객센터', style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.headline1.color
                        )),
                        GestureDetector(
                          onTap: _phone,
                          child: Text('  0507-1386-4446', style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textTheme.headline1.color
                          )),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text('상담시간', style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.headline1.color
                        )),
                        Text('  평일 09시 ~ 18시 (공휴일제외)', style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).textTheme.headline1.color
                        )),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text('카카오톡', style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.headline1.color
                        )),
                        Text('  365일 24시간 연중무휴', style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).textTheme.headline1.color
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _phone() async {
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

  void _kakao() async {
    try {
      if(kIsWeb) {
        //html.window.open('http://pf.kakao.com/_xlxbhlj/chat', '카카오톡 채널');
      } else {
        KakaoContext.clientId = 'e3f5155803af7730f617e92aa89dbe85';
        Uri uri = await TalkApi.instance.channelChatUrl('_xlxbhlj');
        await launchBrowserTab(uri);
      }
    } catch(e) {
      print(e);
    }
  }
}
