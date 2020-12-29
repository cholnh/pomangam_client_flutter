import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_up_model.dart';
import 'package:pomangam_client_flutter/views/pages/sign/in/sign_in_page.dart';
import 'package:provider/provider.dart';

void showSignGuideModal({String predicateUrl, Function onGuestOrder}) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
      ),
      context: Get.overlayContext,
      builder: (context) {
        context.watch<SignUpModel>().predicateUrl = predicateUrl;
        return SignGuideModal(onGuestOrder: onGuestOrder);
      }
  );
}

class SignGuideModal extends StatelessWidget {

  final String predicateUrl;
  final Function onGuestOrder;

  SignGuideModal({this.predicateUrl, this.onGuestOrder});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 15.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
                    child: Align(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('회원 주문시, 많은 혜택이 주어집니다.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Theme.of(context).textTheme.headline1.color)),
                          SizedBox(height: 5),
                          Text('단 8초만 투자하세요!', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Colors.grey)),
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      width: 300.0,
                      height: 48.0,
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Theme.of(Get.context).primaryColor,
                        border: Border.all(color: Theme.of(Get.context).primaryColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                      ),
                      child: Text('로그인', style: TextStyle(color: Theme.of(Get.context).backgroundColor, fontWeight: FontWeight.bold, fontSize: 14.0)),
                    ),
                    onTap: () {
                      Get.to(SignInPage(), duration: Duration.zero);
                    },
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(color: Colors.black26, height: 1.0, thickness: 0.5),
                  ),
                  GestureDetector(
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            kIsWeb ? '앱 설치 시, 비회원 주문이 가능합니다.' : '비회원으로 주문하기',
                            style: TextStyle(color: Colors.grey, fontSize: 14.0))
                        ),
                      ),
                    ),
                    onTap: kIsWeb ? (){} : onGuestOrder,
                  ),
                ],
              ),
            )
          ]
      )
    );
  }
}
