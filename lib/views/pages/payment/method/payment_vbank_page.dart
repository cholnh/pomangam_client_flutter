import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/util/toast_utils.dart';
import 'package:pomangam_client_flutter/domains/payment/payment_type.dart';
import 'package:pomangam_client_flutter/providers/payment/payment_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:pomangam_client_flutter/views/widgets/payment/payment_bottom_bar.dart';
import 'package:provider/provider.dart';

class PaymentVBankPage extends StatefulWidget {

  @override
  _PaymentVBankPageState createState() => _PaymentVBankPageState();
}

class _PaymentVBankPageState extends State<PaymentVBankPage> {

  final FocusNode _focusNode = FocusNode();
  TextEditingController _textEditingController;
  bool isEditMode = true;
  bool isChanged = true;
  bool isTextEmpty = false;
  bool isValidName = true;
  String _savedName;

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController();
    _savedName = context.read<PaymentModel>().payment.vbankName;
    _textEditingController.text = _savedName;
    Future.delayed(Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    String vn = context.watch<PaymentModel>().payment.vbankName;

    return Scaffold(
      appBar: BasicAppBar(
        title: '무통장 입금자명 입력',
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
                                Text('입금자명', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.headline1.color)),
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
                              keyboardType: TextInputType.text,
                              cursorColor: Theme.of(context).primaryColor,
                              style: TextStyle(fontSize: 14.0, color: Theme.of(context).textTheme.headline1.color),
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
                    Text('입금하시는 분 성함을 적어주세요.', style: TextStyle(
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
      String name = _textEditingController.text;
      if(name.isNullOrBlank) {
        DialogUtils.dialog(context, '입금자명을 입력해주세요.');
        return;
      }
      context.read<PaymentModel>()
        ..payment.savePaymentType(PaymentType.COMMON_V_BANK)
        ..payment.saveVBankName(name)
        ..notify();

      Get.back();
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
