import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/_bases/util/toast_utils.dart';
import 'package:pomangam_client_flutter/providers/payment/payment_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:pomangam_client_flutter/views/widgets/payment/payment_bottom_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/in/sign_in_phone_number_input_widget.dart';
import 'package:provider/provider.dart';

class PaymentPhoneNumberPage extends StatefulWidget {

  @override
  _PaymentPhoneNumberPageState createState() => _PaymentPhoneNumberPageState();
}

class _PaymentPhoneNumberPageState extends State<PaymentPhoneNumberPage> {

  final FocusNode _focusNode = FocusNode();
  TextEditingController _textEditingController;
  bool isEditMode = true;
  bool isChanged = true;
  bool isTextEmpty = false;
  bool isValidName = true;
  String _savedPhoneNumber;

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController();
    _savedPhoneNumber = context.read<PaymentModel>().payment.phoneNumber;

    if(!_savedPhoneNumber.isNullOrBlank) {
      String pn = '';
      List digits = _savedPhoneNumber.split('');
      digits.insert(7, ' ');
      digits.insert(3, ' ');
      digits.forEach((digit) => pn += digit);
      _textEditingController.text = pn;
    }

    Future.delayed(Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    String vn = context.watch<PaymentModel>().payment.vbankName;

    return Scaffold(
      appBar: BasicAppBar(
        title: '휴대폰 번호 입력',
        leadingIcon: Icon(CupertinoIcons.back, size: 20, color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: _onChanged,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 40.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('휴대폰 번호', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.headline1.color)),
                              ],
                            ),
                          ),
                          if (isEditMode) Flexible(
                            child: TextFormField(
                              focusNode: _focusNode,
                              controller: _textEditingController,
                              textAlign: TextAlign.end,
                              maxLines: 1,
                              autofocus: true,
                              expands: false,
                              keyboardType: TextInputType.phone,
                              cursorColor: Theme.of(context).primaryColor,
                              style: TextStyle(fontSize: 14.0, color: Theme.of(context).textTheme.headline1.color),
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                                NumberTextInputFormatter(),
                                LengthLimitingTextInputFormatter(13)
                              ],
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Theme.of(context).backgroundColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Theme.of(context).backgroundColor),
                                ),
                              ),
                              onChanged: (text) {
                                setState(() {
                                  this.isTextEmpty = text.isEmpty;
                                });
                              },
                            ),
                          ) else Row(
                            children: <Widget>[
                              Text('$vn', style: TextStyle(fontSize: 14.0, color: Theme.of(context).textTheme.headline1.color)),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text('휴대폰 번호를 적어주세요.', style: TextStyle(
                      fontSize: 12.0,
                      color: Theme.of(context).primaryColor,
                    ))
                  ],
                ),
              ),
            ),
            PaymentBottomBar(
              centerText: '저장',
              isActive: !isTextEmpty,
              onSelected: () => _onBottomSelected(),
              isVisible: isChanged,
            )
          ],
        )
      ),
    );
  }

  void _onChanged() {
    setState(() {
      this.isChanged = true;
      this.isEditMode = true;
    });
  }

  void _onBottomSelected() async {
    try {
      String phoneNumber = _textEditingController.text;
      if(phoneNumber.isNullOrBlank) {
        DialogUtils.dialog(context, '휴대폰 번호를 입력해주세요.');
        return;
      }
      if(StringUtils.onlyNumber(phoneNumber).length != 11) {
        DialogUtils.dialog(context, '휴대폰 번호를 정확하게 입력해주세요.');
        return;
      }
      PaymentModel paymentModel = context.read();
      await paymentModel.payment.savePhoneNumber(StringUtils.onlyNumber(phoneNumber));
      paymentModel.notify();

      Get.back();
      ToastUtils.showToast();
    } catch (error) {
      print(error);
      _verifyError('오류발생');
    }
  }

  void _verifyError(String cause) {
    DialogUtils.dialog(Get.context, '$cause', whenComplete: () {
      FocusScope.of(context).requestFocus(_focusNode);
      setState(() {
        this.isValidName = false;
      });
    });
  }
}
