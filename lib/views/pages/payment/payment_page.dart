import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pomangam_client_flutter/_bases/util/toast_utils.dart';
import 'package:provider/provider.dart';
import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/domains/coupon/coupon.dart';
import 'package:pomangam_client_flutter/domains/payment/cash_receipt/cash_receipt_type.dart';
import 'package:pomangam_client_flutter/domains/payment/payment_type.dart';
import 'package:pomangam_client_flutter/domains/user/point_rank/point_rank.dart';
import 'package:pomangam_client_flutter/providers/cart/cart_model.dart';
import 'package:pomangam_client_flutter/providers/payment/payment_model.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/views/pages/payment/agreement/payment_agreement_page.dart';
import 'package:pomangam_client_flutter/views/pages/payment/cash_receipt/payment_cash_receipt_page.dart';
import 'package:pomangam_client_flutter/views/pages/payment/coupon/payment_coupon_page.dart';
import 'package:pomangam_client_flutter/views/pages/payment/method/payment_method_page.dart';
import 'package:pomangam_client_flutter/views/pages/payment/payment_page_type.dart';
import 'package:pomangam_client_flutter/views/pages/payment/point/payment_point_page.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/payment/payment_bottom_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/payment/payment_item_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/sign_modal.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    PaymentPageType pageType = context.watch<PaymentModel>().pageType;

    CartModel cartModel = Provider.of<CartModel>(context);
    SignInModel signInModel = Provider.of<SignInModel>(context);

    bool isSignIn = signInModel.isSignIn();
    PointRank pointRank = signInModel.userInfo?.userPointRank;
    int totalPrice = cartModel.cart.totalPrice();
    List<Coupon> coupons = cartModel.cart.getAllUsingCoupons();

    return Scaffold(
      appBar: BasicAppBar(title: '결제', elevation: 1.0),
      body: SafeArea(
        child: Consumer<PaymentModel>(
          builder: (_, paymentModel, __) {
            PaymentType paymentType = paymentModel.payment?.paymentType;
            CashReceiptType cashReceiptType = paymentModel.payment?.cashReceipt?.cashReceiptType;
            String cashReceiptNumber = paymentModel.payment?.cashReceipt?.cashReceiptNumber ?? '';
            bool isIssueCashReceipt = paymentModel.payment?.cashReceipt?.isIssueCashReceipt == null ? false : paymentModel.payment.cashReceipt.isIssueCashReceipt;
            bool isPaymentAgree = paymentModel.payment?.isPaymentAgree == null ? false : paymentModel.payment.isPaymentAgree;
            return Column(
              children: <Widget>[
                Expanded(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: pageType == PaymentPageType.FROM_PAYMENT
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 40.0, bottom: 60.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text('결제금액', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: Theme.of(context).textTheme.headline1.color)),
                                        Text(' ${StringUtils.comma(totalPrice)}원', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: Theme.of(Get.context).primaryColor)),
                                      ],
                                    ),
                                    Padding(padding: const EdgeInsets.only(bottom: 5.0)),
                                    // Text('(${StringUtils.comma(pointRank.savedPoint(totalPrice))}포인트 적립)', style: TextStyle(fontSize: 13.0, color: Colors.black.withOpacity(0.5)))
                                    pointRank != null
                                        ? Text('(결제금액의 ${pointRank.percentSavePoint}% 포인트 적립)', style: TextStyle(fontSize: 13.0, color: Colors.black.withOpacity(0.5)))
                                        : Text('(로그인시 포인트 적립이 가능합니다)', style: TextStyle(fontSize: 13.0, color: Colors.black.withOpacity(0.5)))
                                  ],
                                ),
                              ),
                          )
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 30.0),
                          ),
                      ),
                      PaymentItemWidget(
                        title: '결제수단',
                        subTitle: '${convertPaymentTypeToText(paymentType)}${_vbankText(paymentType)}' ,
                        onSelected: () => Get.to(PaymentMethodPage(), transition: Transition.cupertino, duration: Duration.zero),
                      ),
                      PaymentItemWidget(
                        title: '포인트',
                        subTitle: isSignIn
                          ? cartModel.cart.usingPoint > 0
                            ? '${StringUtils.comma(cartModel.cart.usingPoint)}포인트 사용'
                            : (signInModel.userInfo?.userPoint ?? 0) > 0
                                ? '${StringUtils.comma(signInModel.userInfo?.userPoint ?? 0)}포인트 사용가능'
                                : '포인트 없음'
                          : '로그인이 필요합니다',
                        onSelected: isSignIn
                          ? () => Get.to(PaymentPointPage(), transition: Transition.cupertino, duration: Duration.zero)
                          : () => showSignModal(predicateUrl: Get.currentRoute),
                        //isActive: isSignIn,
                      ),
                      PaymentItemWidget(
                        title: '할인쿠폰',
                        subTitle: coupons.length > 0
                          ? _couponTitle(coupons)
                          : '쿠폰코드를 입력 또는 선택해 주세요',
                        onSelected: () => Get.to(PaymentCouponPage(), transition: Transition.cupertino, duration: Duration.zero),
                      ),
                      PaymentItemWidget(
                        title: '현금영수증',
                        subTitle: isIssueCashReceipt ? '${convertCashReceiptTypeToShortText(cashReceiptType)} $cashReceiptNumber' : '미발급',
                        onSelected: () => Get.to(PaymentCashReceiptPage(), transition: Transition.cupertino, duration: Duration.zero),
                      ),
                      PaymentItemWidget(
                        title: '결제에 관한 동의',
                        subTitle: !isPaymentAgree || paymentModel.payment?.paymentAgreeDate == null ? '결제를 위해 동의가 필요합니다.' : '${_agreementDate(paymentModel.payment.paymentAgreeDate)} 동의 완료',
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            isPaymentAgree ? '동의' : '동의 안 함',
                            style: TextStyle(color: Theme.of(Get.context).primaryColor, fontSize: 14.0, fontWeight: FontWeight.bold)),
                        ),
                        onSelected: () => Get.to(PaymentAgreementPage(), transition: Transition.cupertino, duration: Duration.zero),
                      )
                    ],
                  ),
                ),
                pageType == PaymentPageType.FROM_PAYMENT
                ? PaymentBottomBar(
                    centerText: '완료',
                    onSelected: () => _onBottomSelected(context),
                )
                : Container()
              ],
            );
          },
        ),
      )
    );
  }

  String _vbankText(PaymentType paymentType) {
    if(paymentType == PaymentType.COMMON_V_BANK) {
      String vn = context.read<PaymentModel>().payment.vbankName;
      return vn.isNullOrBlank ? ' (입금자 미설정)' : ' (입금자명 $vn)';
    }
    return '';
  }

  void _onBottomSelected(BuildContext context) {
    Get.back();

    ToastUtils.showToast();
  }

  String _agreementDate(DateTime dt) {
    return DateFormat('yyyy년 MM월 dd일').format(dt);
  }

  void _init({bool isBuild = false}) {
  }

  String _couponTitle(List<Coupon> coupons) {
    String title = '';
    for(int i=0; i<coupons.length; i++) {
      title += '${coupons[i].title}(${StringUtils.comma(coupons[i].discountCost)}원)';
      if(i != coupons.length - 1) {
        title += ', ';
      }
    }
    return title;
  }
}