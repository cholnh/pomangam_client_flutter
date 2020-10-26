import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_up_model.dart';
import 'package:pomangam_client_flutter/views/pages/sign/in/sign_in_page.dart';
import 'package:provider/provider.dart';

void showSignModal({String predicateUrl}) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
      ),
      context: Get.overlayContext,
      builder: (context) {
        context.watch<SignUpModel>().predicateUrl = predicateUrl;
        return SignModal(
            onSignIn: () {
              Get.to(SignInPage(), duration: Duration.zero);
            },
            onSignUp: () {
              Get.to(SignInPage(), duration: Duration.zero);
            }
        );
      }
  );
}

class SignModal extends StatelessWidget {
  final Function onSignIn;
  final Function onSignUp;

  SignModal({this.onSignIn, this.onSignUp});

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
                    padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 40.0),
                    child: Align(
                      child: Text('로그인이 필요합니다.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Theme.of(context).textTheme.headline1.color)),
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
                      child: Text('간편가입', style: TextStyle(color: Theme.of(Get.context).backgroundColor, fontWeight: FontWeight.bold, fontSize: 14.0)),
                    ),
                    onTap: onSignUp,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                    child: Divider(color: Colors.black26, height: 1.0, thickness: 0.5),
                  ),
                  GestureDetector(
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: Text('기존 계정으로 로그인', style: TextStyle(color: Colors.grey, fontSize: 14.0))),
                      ),
                    ),
                    onTap: onSignIn,
                  )
                ],
              ),
            )
          ]
      )
    );
  }
}
