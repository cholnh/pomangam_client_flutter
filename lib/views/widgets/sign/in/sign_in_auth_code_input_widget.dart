import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:provider/provider.dart';

class SignInAuthCodeInputWidget extends StatelessWidget {

  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onSelected;
  final bool isView;

  SignInAuthCodeInputWidget({
    this.controller,
    this.focusNode,
    this.onSelected,
    this.isView,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isView ? 1.0 : 0.0,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: PinCodeTextField(
              appContext: context,
              enabled: true,
              length: 4,
              controller: controller,
              focusNode: focusNode,
              autoDisposeControllers: true,
              autoDismissKeyboard: true,
              autoFocus: true,
              animationType: AnimationType.scale,
              animationDuration: Duration(milliseconds: 300),
              dialogConfig: DialogConfig(
                dialogTitle: '포만감',
                dialogContent: '코드를 붙여넣기 하시겠습니까?',
              ),
              keyboardType: TextInputType.number,
              cursorColor: Theme.of(context).primaryColor,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 70,
                fieldWidth: 58,
                activeColor: Theme.of(Get.context).primaryColor,
                inactiveColor: Colors.grey,
                selectedColor: Theme.of(Get.context).primaryColor,
              ),
              onTap: () {
                FocusScope.of(context).requestFocus(focusNode);
              },
            ),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 20.0)),
          Consumer<SignInModel>(
            builder: (_, model, __) {
              bool isLock = model.signInAuthCodeLock;

              return GestureDetector(
                onTap: () => isLock || !isView ? {} : onSelected(),
                child: SizedBox(
                  height: 50.0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(Get.context).primaryColor,
                        border: Border.all(color: Theme.of(Get.context).primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                    ),
                    child: Center(
                      child: isLock
                        ? CupertinoActivityIndicator()
                        : Text('확인', style: TextStyle(color: Theme.of(Get.context).backgroundColor, fontWeight: FontWeight.bold, fontSize: 17.0)),
                    ),
                  ),
                ),
              );
            }
          )
        ],
      ),
    );
  }
}
