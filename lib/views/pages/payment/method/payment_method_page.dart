import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/util/toast_utils.dart';
import 'package:pomangam_client_flutter/domains/payment/payment_type.dart';
import 'package:pomangam_client_flutter/providers/payment/payment_model.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/views/pages/payment/method/payment_vbank_page.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:pomangam_client_flutter/views/widgets/payment/method/payment_method_add_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/payment/method/payment_method_common_type_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/payment/payment_bottom_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/sign_modal.dart';
import 'package:provider/provider.dart';

class PaymentMethodPage extends StatefulWidget {
  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {

  PaymentType viewPaymentType;
  bool isChanged = false;

  @override
  void initState() {
    super.initState();
    PaymentModel paymentModel = context.read();
    viewPaymentType = paymentModel.payment?.paymentType;
    if(!context.read<SignInModel>().isSignIn()) {
      if(viewPaymentType == PaymentType.CONTACT_CREDIT_CARD || viewPaymentType == PaymentType.CONTACT_CASH) {
        viewPaymentType = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SignInModel signInModel = context.watch();
    bool isSignIn = signInModel.isSignIn();

    return Scaffold(
      appBar: BasicAppBar(
        title: '결제수단',
        leadingIcon: const Icon(CupertinoIcons.back, size: 20, color: Colors.black),
        elevation: 1.0,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
                      child: Text('내 결제', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.headline1.color)),
                    ),
//                    isSignIn ? PaymentMethodUserTypeWidget(
//                      isFirst: true,
//                      bankName: '우리카드',
//                      bankNumberPreview: '3355**79**55*',
//                      isSelected: viewPaymentType == PaymentType.PERIODIC_CREDIT_CARD,
//                      paymentType: PaymentType.PERIODIC_CREDIT_CARD,
//                      onSelected: () => _onTypeSelected(PaymentType.PERIODIC_CREDIT_CARD),
//                    ) : Container(),
//                    isSignIn ? PaymentMethodUserTypeWidget(
//                      bankName: '카카오뱅크',
//                      bankNumberPreview: '565**45****1',
//                      isSelected: viewPaymentType == PaymentType.PERIODIC_FIRM_BANK,
//                      paymentType: PaymentType.PERIODIC_FIRM_BANK,
//                      onSelected: () => _onTypeSelected(PaymentType.PERIODIC_FIRM_BANK),
//                    ) : Container(),
                    Padding(padding: const EdgeInsets.only(bottom: 10.0)),
                    PaymentMethodAddWidget(
                      onSelected: _onAddSelected,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0, bottom: 10.0),
                      child: Text('일반 결제', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.headline1.color)),
                    ),
                    PaymentMethodCommonTypeWidget(
                      isFirst: true,
                      isActive: false, // !kIsWeb,
                      paymentType: PaymentType.COMMON_CREDIT_CARD,
                      isSelected: viewPaymentType == PaymentType.COMMON_CREDIT_CARD,
                      onSelected: () => _onTypeSelected(PaymentType.COMMON_CREDIT_CARD),
                      subtitle: '준비중' // !kIsWeb ? null : '앱 설치 후 사용 가능',
                    ),
                    PaymentMethodCommonTypeWidget(
                      paymentType: PaymentType.COMMON_V_BANK,
                      isSelected: viewPaymentType == PaymentType.COMMON_V_BANK,
                      onSelected: isSignIn
                          ? () => Get.to(PaymentVBankPage())
                          : () => showSignModal(predicateUrl: Get.currentRoute),
                    ),
                   // PaymentMethodCommonTypeWidget(
                   //   paymentType: PaymentType.COMMON_KAKAOPAY,
                   //   isSelected: viewPaymentType == PaymentType.COMMON_KAKAOPAY,
                   //   onSelected: () => _onTypeSelected(PaymentType.COMMON_KAKAOPAY),
                   // ),
                    PaymentMethodCommonTypeWidget(
                      isActive: false, // !kIsWeb,
                      paymentType: PaymentType.COMMON_PHONE,
                      isSelected: viewPaymentType == PaymentType.COMMON_PHONE,
                      onSelected: () => _onTypeSelected(PaymentType.COMMON_PHONE),
                      subtitle: '준비중' // !kIsWeb ? null : '앱 설치 후 사용 가능',
                    ),
                    PaymentMethodCommonTypeWidget(
                      isActive: false, // !kIsWeb,
                      paymentType: PaymentType.COMMON_BANK,
                      isSelected: viewPaymentType == PaymentType.COMMON_BANK,
                      onSelected: () => _onTypeSelected(PaymentType.COMMON_BANK),
                      subtitle: '준비중' // !kIsWeb ? null : '앱 설치 후 사용 가능',
                    ),
                   // PaymentMethodCommonTypeWidget(
                   //   paymentType: PaymentType.COMMON_REMOTE_PAY,
                   //   isSelected: viewPaymentType == PaymentType.COMMON_REMOTE_PAY,
                   //   onSelected: () => _onTypeSelected(PaymentType.COMMON_REMOTE_PAY),
                   // )

                    PaymentMethodCommonTypeWidget(
                      isActive: true,
                      paymentType: PaymentType.CONTACT_CREDIT_CARD,
                      isSelected: viewPaymentType == PaymentType.CONTACT_CREDIT_CARD,
                      onSelected: isSignIn
                        ? () => _onTypeSelected(PaymentType.CONTACT_CREDIT_CARD)
                        : () => showSignModal(predicateUrl: Get.currentRoute),
                      subtitle: isSignIn ? null : '로그인후 사용가능',
                    ),
                    PaymentMethodCommonTypeWidget(
                      isActive: false, // isSignIn,
                      paymentType: PaymentType.CONTACT_CASH,
                      isSelected: viewPaymentType == PaymentType.CONTACT_CASH,
                      onSelected: isSignIn
                        ? () => _onTypeSelected(PaymentType.CONTACT_CASH)
                        : () => showSignModal(predicateUrl: Get.currentRoute),
                      subtitle: '준비중' // isSignIn ? null : '로그인후 사용가능',
                    ),
                  ],
                ),
              ),
            ),
            PaymentBottomBar(
              centerText: '저장',
              isActive: true,
              onSelected: () => _onBottomSelected(),
              isVisible: isChanged,
            )
          ],
        ),
      ),
    );
  }

  void _onTypeSelected(PaymentType type) {
    setState(() {
      this.isChanged = true;
      this.viewPaymentType = type;
    });
  }

  void _onBottomSelected() {
    context.read<PaymentModel>()
      ..payment.savePaymentType(this.viewPaymentType)
      ..notify();

    Get.back(); //Navigator.pop(context, false);

    ToastUtils.showToast();
  }

  void _onAddSelected() {
    bool isSignIn = context.read<SignInModel>().isSignIn();
    if(isSignIn) {
      // Get.to(PaymentMethodAddPage(), transition: Transition.cupertino, duration: Duration.zero);
      DialogUtils.dialog(context, '준비 중입니다.');
    } else {
      showSignModal(predicateUrl: Get.currentRoute);
    }
  }
}