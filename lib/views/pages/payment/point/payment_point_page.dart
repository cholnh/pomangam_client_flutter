import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pomangam_client_flutter/_bases/util/toast_utils.dart';
import 'package:pomangam_client_flutter/providers/payment/payment_model.dart';
import 'package:pomangam_client_flutter/views/pages/payment/payment_page_type.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:provider/provider.dart';
import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/domains/user/point_log/point_log.dart';
import 'package:pomangam_client_flutter/domains/user/point_log/point_type.dart';
import 'package:pomangam_client_flutter/providers/cart/cart_model.dart';
import 'package:pomangam_client_flutter/providers/point/point_model.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/payment/point/payment_point_add_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/payment/point/payment_point_log_item_widget.dart';

class PaymentPointPage extends StatefulWidget {
  @override
  _PaymentPointPageState createState() => _PaymentPointPageState();
}

class _PaymentPointPageState extends State<PaymentPointPage> {

  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    Provider.of<PointModel>(context, listen: false).fetchLogs();
    CartModel cartModel = Provider.of<CartModel>(context, listen: false);
    _textEditingController.text = cartModel.cart.usingPoint <= 0 ? '' : cartModel.cart.usingPoint.toString();
  }

  @override
  Widget build(BuildContext context) {
    PaymentPageType pageType = context.watch<PaymentModel>().pageType;
    bool isFromSetting = pageType == PaymentPageType.FROM_SETTING;

    int userPoint = context.watch<SignInModel>().userInfo?.userPoint ?? 0;

    return Scaffold(
        appBar: BasicAppBar(
          title: isFromSetting ? '포인트' : '보유포인트 ${StringUtils.comma(userPoint)}P',
          leadingIcon: Icon(CupertinoIcons.back, color: Theme.of(context).iconTheme.color, size: 20),
          actions: isFromSetting ? [
            Center(child: Text('최근 1년 내역', style: TextStyle(fontSize: 12.0, color: Theme.of(context).textTheme.subtitle2.color))),
            SizedBox(width: 15)
          ] : null,
          elevation: 1.0,
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              if (!isFromSetting) PaymentPointAddWidget(
                textEditingController: _textEditingController,
                userPoint: userPoint,
                onSelected: _onSelected,
              ),
              if (isFromSetting) Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('보유포인트 ${StringUtils.comma(userPoint)}P', style: TextStyle(
                        fontSize: 23.0,
                        color: Theme.of(context).textTheme.headline1.color,
                        fontWeight: FontWeight.w700
                    )),
                    SizedBox(height: 15),
                    Text('1원 이상 1원 단위로 사용 가능', style: TextStyle(
                        fontSize: 12.0,
                        color: Theme.of(context).textTheme.subtitle2.color
                    )),
                    SizedBox(height: 5),
                    Text('최대 50만원까지 보유 가능', style: TextStyle(
                        fontSize: 12.0,
                        color: Theme.of(context).textTheme.subtitle2.color
                    )),
                    SizedBox(height: 15),
                    Text('이번 달 소멸 예정포인트는 0원입니다', style: TextStyle(
                        fontSize: 12.0,
                        color: Theme.of(context).textTheme.subtitle2.color
                    )),
                  ],
                ),
              ),
              Divider(height: 15.0, thickness: 8.0, color: Colors.grey[100]),
              Expanded(
                child: Consumer<PointModel>(
                    builder: (_, pointModel, __) {
                      if(pointModel.isFetching) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: CupertinoActivityIndicator(),
                        );
                      }

                      List<PointLog> pointLogs = pointModel.pointLogs;
                      if(pointLogs.length == 0) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text('포인트 내역이 없습니다.', style: TextStyle(color: Theme.of(context).textTheme.subtitle2.color, fontSize: 12.0)),
                        );
                      }
                      return CustomScrollView(
                        physics: BouncingScrollPhysics(),
                        slivers: <Widget>[
                          SliverList(
                              delegate: SliverChildBuilderDelegate((context, index) {
                                PointLog pointLog = pointLogs[index];
                                return PaymentPointLogItemWidget(
                                    index: index,
                                    title: _pointLogTitle(pointLog),
                                    subTitle: _pointSubTitle(pointLog),
                                    trailingText: _pointLogTrailingText(pointLog)
                                );
                              }, childCount: pointLogs.length)
                          )
                        ],
                      );
                    }
                ),
              ),
            ],
          ),
        )
    );
  }

  void _onSelected() {
    CartModel cartModel = context.read();

    int usingPoint = int.tryParse(_textEditingController.text) ?? 0;
    int userPoint = context.read<SignInModel>().userInfo?.userPoint ?? 0;

    if(usingPoint > cartModel.cart.totalPrice()) {
      DialogUtils.dialog(context, '결제금액 보다 많습니다.');
      return;
    }

    if(usingPoint > userPoint) {
      DialogUtils.dialog(context, '보유포인트가 부족합니다');
      return;
    }
    if(usingPoint <= 0) {
      usingPoint = 0;
    }
    cartModel
      ..cart.usingPoint = usingPoint
      ..notify();

    Get.back();

    ToastUtils.showToast();
  }

  String _pointLogTitle(PointLog pointLog) {
    switch(pointLog.pointType) {

      case PointType.ISSUED_BY_PROMOTION:
        return '프로모션 적립';
      case PointType.ISSUED_BY_BUY:
      case PointType.USED_BY_BUY:
        return '주문번호 no.${pointLog.idxOrder}';
      case PointType.UPDATED_PLUS_BY_ADMIN:
        return '관리자에 의한 적립';
      case PointType.UPDATED_MINUS_BY_ADMIN:
        return '관리자에 의한 차감';
      case PointType.ROLLBACK_ISSUED_BY_PAYMENT_CANCEL:
      case PointType.ROLLBACK_SAVED_BY_PAYMENT_CANCEL:
        return '주문번호 no.${pointLog.idxOrder} (주문취소)';
    }
    return '알 수 없음';
  }

  String _pointLogTrailingText(PointLog pointLog) {
    String trailingText = '';
    switch(pointLog.pointType) {

      case PointType.ISSUED_BY_PROMOTION:
      case PointType.ISSUED_BY_BUY:
      case PointType.UPDATED_PLUS_BY_ADMIN:
      case PointType.ROLLBACK_ISSUED_BY_PAYMENT_CANCEL:
        trailingText = '+ ${StringUtils.comma(pointLog.point)}P 적립';
        break;
      case PointType.ROLLBACK_SAVED_BY_PAYMENT_CANCEL:
      case PointType.USED_BY_BUY:
      case PointType.UPDATED_MINUS_BY_ADMIN:
        trailingText = '- ${StringUtils.comma(pointLog.point)}P 차감';
        break;

    }
    return trailingText;
  }

  String _pointSubTitle(PointLog pointLog) {
    String subTitle = '';
    switch(pointLog.pointType) {

      case PointType.ISSUED_BY_PROMOTION:
      case PointType.ISSUED_BY_BUY:
      case PointType.UPDATED_PLUS_BY_ADMIN:
      case PointType.ROLLBACK_ISSUED_BY_PAYMENT_CANCEL:
        subTitle = '${_dateFormat(pointLog.registerDate)} (${_dateFormat(pointLog.expiredDate)} 만료)';
        break;
      case PointType.ROLLBACK_SAVED_BY_PAYMENT_CANCEL:
        subTitle = '적립 포인트 회수';
        break;
      case PointType.USED_BY_BUY:
        subTitle = '포인트 사용';
        break;
      case PointType.UPDATED_MINUS_BY_ADMIN:
        subTitle = '포인트 차감';
        break;

    }
    return subTitle;
  }

  String _dateFormat(DateTime dt) {
    return DateFormat('yyyy.MM.dd').format(dt);
  }
}
