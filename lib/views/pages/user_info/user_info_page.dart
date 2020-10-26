import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:package_info/package_info.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/domains/coupon/coupon.dart';
import 'package:pomangam_client_flutter/domains/payment/cash_receipt/cash_receipt_type.dart';
import 'package:pomangam_client_flutter/domains/payment/payment_type.dart';
import 'package:pomangam_client_flutter/providers/cart/cart_model.dart';
import 'package:pomangam_client_flutter/providers/payment/payment_model.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/views/pages/_bases/base_page.dart';
import 'package:pomangam_client_flutter/views/pages/alarm/alarm_page.dart';
import 'package:pomangam_client_flutter/views/pages/cs/cs_page.dart';
import 'package:pomangam_client_flutter/views/pages/event/event_page.dart';
import 'package:pomangam_client_flutter/views/pages/notice/notice_page.dart';
import 'package:pomangam_client_flutter/views/pages/payment/agreement/payment_agreement_page.dart';
import 'package:pomangam_client_flutter/views/pages/payment/cash_receipt/payment_cash_receipt_page.dart';
import 'package:pomangam_client_flutter/views/pages/payment/coupon/payment_coupon_page.dart';
import 'package:pomangam_client_flutter/views/pages/payment/method/payment_method_page.dart';
import 'package:pomangam_client_flutter/views/pages/payment/payment_page_type.dart';
import 'package:pomangam_client_flutter/views/pages/payment/point/payment_point_page.dart';
import 'package:pomangam_client_flutter/views/pages/user_info/nickname/nickname_page.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:pomangam_client_flutter/views/widgets/payment/payment_item_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/sign_modal.dart';
import 'package:pomangam_client_flutter/views/widgets/user_info/user_info_category_title_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/user_info/user_info_profile_widget.dart';
import 'package:provider/provider.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  String version;
  String buildNumber;

  @override
  void initState() {
    context.read<PaymentModel>().pageType = PaymentPageType.FROM_SETTING;
    _appVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    CartModel cartModel = context.watch();
    SignInModel signInModel = context.watch();
    bool isSignIn = signInModel.isSignIn();
    List<Coupon> coupons = cartModel.cart.getAllUsingCoupons();

    return ModalProgressHUD(
      inAsyncCall: signInModel.isSigningOut,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: BasicAppBar(
          title: '내 정보',
          isLeading: false,
          elevation: 1.0
        ),
        body: SafeArea(
          child: Consumer<PaymentModel>(
            builder: (_, paymentModel, __) {
              PaymentType paymentType = paymentModel.payment?.paymentType;
              CashReceiptType cashReceiptType = paymentModel.payment?.cashReceipt?.cashReceiptType;
              String cashReceiptNumber = paymentModel.payment?.cashReceipt?.cashReceiptNumber ?? '';
              bool isIssueCashReceipt = paymentModel.payment?.cashReceipt?.isIssueCashReceipt == null ? false : paymentModel.payment.cashReceipt.isIssueCashReceipt;
              bool isPaymentAgree = paymentModel.payment?.isPaymentAgree == null ? false : paymentModel.payment.isPaymentAgree;
              return CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  UserInfoProfileWidget(),
                  if(signInModel.isSignIn()) UserInfoCategoryTitleWidget(title: '계정'),
                  if(signInModel.isSignIn()) PaymentItemWidget(
                    title: '닉네임 변경',
                    onSelected: () => Get.to(NicknamePage(), transition: Transition.cupertino, duration: Duration.zero),
                    isLast: true,
                  ),

                  UserInfoCategoryTitleWidget(title: '이용안내'),
                  PaymentItemWidget(
                    title: '공지사항',
                    onSelected: () => Get.to(NoticePage(), transition: Transition.cupertino, duration: Duration.zero),
                  ),
                  PaymentItemWidget(
                    title: '이벤트',
                    onSelected: () => Get.to(EventPage(), transition: Transition.cupertino, duration: Duration.zero),
                  ),
                  PaymentItemWidget(
                    title: '고객센터',
                    onSelected: () => Get.to(CsPage(), transition: Transition.cupertino, duration: Duration.zero),
                    isLast: true,
                  ),

                  UserInfoCategoryTitleWidget(title: '결제'),
                  PaymentItemWidget(
                    title: '결제수단',
                    subTitle: convertPaymentTypeToText(paymentType),
                    onSelected: () => Get.to(PaymentMethodPage(), transition: Transition.cupertino, duration: Duration.zero),
                  ),
                  PaymentItemWidget(
                    title: '포인트',
                    subTitle: isSignIn
                        ? (signInModel.userInfo?.userPoint ?? 0) > 0
                        ? '${StringUtils.comma(signInModel.userInfo?.userPoint ?? 0)}포인트 사용가능'
                        : '포인트 없음'
                        : '로그인이 필요합니다',
                    onSelected: isSignIn
                        ? () => Get.to(PaymentPointPage(), transition: Transition.cupertino, duration: Duration.zero)
                        : () => showSignModal(predicateUrl: Get.currentRoute),
                    //isActive: isSignIn,
                  ),
                  PaymentItemWidget(
                    title: '할인쿠폰 등록',
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
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14.0, fontWeight: FontWeight.bold)),
                    ),
                    onSelected: () => Get.to(PaymentAgreementPage(), transition: Transition.cupertino, duration: Duration.zero),
                    isLast: true,
                  ),

                  if(!kIsWeb) UserInfoCategoryTitleWidget(title: '앱 설정'),
                  if(!kIsWeb) PaymentItemWidget(
                    title: '앱 버전',
                    trailing: Text(version.isNullOrBlank ? '' : '$version+$buildNumber', style: TextStyle(
                      color: Colors.black.withOpacity(0.5)
                    )),
                    isLast: true,
                  ),
//                  PaymentItemWidget(
//                    title: '알림 설정',
//                    onSelected: () => Get.to(AlarmPage(), transition: Transition.cupertino, duration: Duration.zero),
//                    isLast: true,
//                  ),

                  if(signInModel.isSignIn()) UserInfoCategoryTitleWidget(title: '기타'),
                  if(signInModel.isSignIn()) PaymentItemWidget(
                    title: '회원 탈퇴',
                    onSelected: () {
                      DialogUtils.dialogYesOrNo(context, '영구 탈퇴 하시겠습니까?', onConfirm: (dialogContext) async {
                        DialogUtils.dialog(
                          context,
                          '고객센터로 문의하시기 바랍니다.',
                          height: 180,
                          contents: GestureDetector(
                            onTap: () {
                              if(Navigator.of(Get.overlayContext).canPop()) {
                                Navigator.of(Get.overlayContext).pop();
                              }
                              Get.to(CsPage(), duration: Duration.zero, transition: Transition.cupertino);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('고객센터 바로가기', style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).primaryColor
                              )),
                            ),
                          )
                        );
                      });
                    },
                  ),
                  if(signInModel.isSignIn()) PaymentItemWidget(
                    title: '로그아웃',
                    onSelected: () {
                      DialogUtils.dialogYesOrNo(context, '로그아웃 하시겠습니까?', onConfirm: (dialogContext) async {
                        if(!signInModel.isSigningOut) {
                          await signInModel.signOut();
                          Get.offAll(BasePage(), transition: Transition.fade);
                          if( Navigator.of(dialogContext).canPop()) {
                            Navigator.of(dialogContext).pop();
                          }
                        }
                      });
                    },
                    isLast: true,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String _agreementDate(DateTime dt) {
    return DateFormat('yyyy년 MM월 dd일').format(dt);
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

  void _appVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      this.version = packageInfo.version;
      this.buildNumber = packageInfo.buildNumber;
    });
  }
}
