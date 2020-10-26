import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/domains/cart/cart.dart';
import 'package:pomangam_client_flutter/domains/order/order_request.dart';
import 'package:pomangam_client_flutter/domains/order/order_response.dart';
import 'package:pomangam_client_flutter/domains/payment/payment.dart';
import 'package:pomangam_client_flutter/domains/payment/payment_type.dart';
import 'package:pomangam_client_flutter/providers/cart/cart_model.dart';
import 'package:pomangam_client_flutter/providers/order/order_info_model.dart';
import 'package:pomangam_client_flutter/providers/order/order_model.dart';
import 'package:pomangam_client_flutter/providers/payment/payment_model.dart';
import 'package:pomangam_client_flutter/providers/payment/pg_model.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/views/pages/order/order_processing/order_processing_page.dart';
import 'package:pomangam_client_flutter/views/pages/payment/agreement/payment_agreement_page.dart';
import 'package:pomangam_client_flutter/views/pages/payment/agreement/payment_agreement_page_type.dart';
import 'package:pomangam_client_flutter/views/pages/payment/method/payment_method_page.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/sign_guide_modal.dart';
import 'package:provider/provider.dart';

import 'cart_body_widget.dart';
import 'cart_footer_widget.dart';
import 'cart_header_widget.dart';

class CartPanelWidget extends StatelessWidget {

  final Function onSaveOrder;

  CartPanelWidget({this.onSaveOrder});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            color: Colors.grey,
          ),
        ]
      ),
      margin: const EdgeInsets.fromLTRB(10.0, 24.0, 10.0, 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 53.0),
            child: Column(
              children: <Widget>[
                CartHeaderWidget(),
                Flexible(
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: <Widget>[
                      CartBodyWidget()
                    ],
                  ),
                ),
                CartFooterWidget()
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Consumer<OrderModel>(
              builder: (_, orderModel, __) {
                bool isSaving = orderModel.isOrderProcessing;
                return Consumer<CartModel>(
                  builder: (_, cartModel, __) {
                    bool isOrderable = cartModel.cart?.items?.first?.isOrderable ?? false;
                    // bool isPayable = context.read<PaymentModel>().payment.isReadyPayment();
                    bool isOrderableTime = cartModel.cart.isOrderableDateTime();

                    return GestureDetector(
                      child: Opacity(
                        opacity: (!isSaving) && isOrderable && isOrderableTime ? 1.0 : 0.5,
                        child: Container(
                          color: Theme.of(Get.context).primaryColor,
                          width: MediaQuery.of(context).size.width,
                          height: 53.0,
                          child: Center(
                            child: isSaving
                              ? CupertinoActivityIndicator()
                              : Text('${StringUtils.comma(cartModel.cart.totalPrice())}원 결제하기', style: TextStyle(color: Theme.of(Get.context).backgroundColor, fontWeight: FontWeight.bold, fontSize: 15.0)),
                          ),
                        ),
                      ),
                      onTap: (!isSaving) && isOrderable && isOrderableTime
                          ? () => _signGuide()
                          : () {},
                    );
                  }
                );
              }
            )
          )
        ],
      ),
    );
  }

  void _signGuide() {
    // 로그인 유도
    if(Get.context.read<SignInModel>().isSignIn()) {
      _check();
    } else {
      showSignGuideModal(predicateUrl: Get.currentRoute, onGuestOrder: _check);
    }
  }

  void _saveOrder() async {
    OrderModel orderModel = Get.context.read<OrderModel>();
    if(orderModel.isOrderProcessing) return;
    orderModel.changeIsOrderProcessing(true);

    Payment payment = Get.context.read<PaymentModel>().payment;
    Cart cart = Get.context.read<CartModel>().cart;

    if(payment.paymentType == PaymentType.COMMON_V_BANK && payment.vbankName.isNullOrBlank) {
      DialogUtils.dialog(Get.context, '입금자명을 설정해주세요.');
      orderModel.changeIsOrderProcessing(false);
      return;
    }

    OrderRequest request = await OrderRequest.fromCartAndPayment(cart, payment);
    OrderResponse response = await orderModel.save(orderRequest: request);

    if(response != null) {
      if(payment.paymentType == PaymentType.CONTACT_CREDIT_CARD ||
          payment.paymentType == PaymentType.CONTACT_CASH ||
          payment.paymentType == PaymentType.COMMON_V_BANK ||
          cart.totalPrice() <= 0
      ) {
        if(payment.paymentType == PaymentType.COMMON_V_BANK) {
          // 가상계좌 입금대기
          orderModel.changeBootpayVbank(
              oIdx: response.idx,
              vbankPrice: response.paymentCost
          );
          orderModel.changeStatus(2);
        }

        // 대면 결제
        if(kIsWeb) {
          Get.to(OrderProcessingPage(), transition: Transition.fade);
        } else {
          Get.offAll(OrderProcessingPage(), transition: Transition.fade, predicate: (Route route) {
            return route.isFirst;
          });
        }
        orderModel.changeIsValidOrder(true);
        Get.context.read<CartModel>().clear();
        Get.context.read<SignInModel>().renewUserInfo();
        Get.context.read<OrderInfoModel>().fetchToday(isForceUpdate: true);
      } else {
        orderModel.vbankClear();
        Get.context.read<PgModel>().request(response);
      }
    } else {
      orderModel.changeIsOrderProcessing(false);
    }
  }

  void _check() async {
    Payment payment = Get.context.read<PaymentModel>().payment;
    if(payment.paymentType == null) {
      Get.to(PaymentMethodPage(),
        transition: Transition.cupertino,
        duration: Duration.zero,
      ).whenComplete(() {
        if(!kIsWeb) {
          Navigator.pop(Get.overlayContext);
        }
        _check();
      });
      return;
    }
    if(!payment.isPaymentAgree) {
      Get.to(PaymentAgreementPage(),
        arguments: PaymentAgreementPageType.FROM_CART,
        transition: Transition.cupertino,
        duration: Duration.zero,
      ).whenComplete(() {
        if(!kIsWeb) {
          Navigator.pop(Get.overlayContext);
        }
        _check();
      });
      return;
    }
    _saveOrder();
  }
}
