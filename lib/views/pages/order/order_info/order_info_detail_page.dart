import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pomangam_client_flutter/_bases/util/toast_utils.dart';
import 'package:pomangam_client_flutter/domains/order/item/order_item_response.dart';
import 'package:pomangam_client_flutter/domains/order/order_response.dart';
import 'package:pomangam_client_flutter/domains/order/order_type.dart';
import 'package:pomangam_client_flutter/providers/order/order_info_model.dart';
import 'package:pomangam_client_flutter/providers/order/order_model.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/views/pages/store/review/store_review_select_page.dart';
import 'package:pomangam_client_flutter/views/pages/store/review/store_review_write_page.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:pomangam_client_flutter/views/widgets/order/order_info/detail/order_info_detail_bottom_btn_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/order/order_info/detail/order_info_detail_info_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/order/order_info/detail/order_info_detail_items_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/sign/sign_modal.dart';
import 'package:provider/provider.dart';

class OrderInfoDetailPage extends StatelessWidget {

  final OrderResponse order;

  OrderInfoDetailPage({this.order});

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: context.watch<OrderInfoModel>().isCanceling,
      child: Scaffold(
        bottomNavigationBar: _isDone()
          ? OrderInfoDetailBottomBtnWidget(
              title: _isAllWrote()
                ? '리뷰 작성 완료'
                : !_isDeadline() ? '리뷰쓰기' : '리뷰쓰기 기간이 지났습니다.',
              onTap: _signGuide,
              isActive: !_isAllWrote() && !_isDeadline(),
          )
          : null,
        appBar: BasicAppBar(
          title: '주문상세',
          leadingIcon: const Icon(CupertinoIcons.back, size: 20, color: Colors.black),
          elevation: 1.0,
          actions: _isValidCancel() ? [
            GestureDetector(
              onTap: _onCancel,
              child: Material(
                color: Colors.transparent,
                child: Center(
                  child: Text('주문취소', style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).primaryColor
                  )),
                ),
              ),
            ),
            SizedBox(width: 15)
          ] : null,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderInfoDetailInfoWidget(order: order),
                Divider(thickness: 4.0, height: 0.5, color: Colors.black.withOpacity(0.03)),
                OrderInfoDetailItemsWidget(order: order),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isDone() {
    return order.orderType == OrderType.DELIVERY_SUCCESS;
  }

  bool _isDeadline() {
    DateTime dl = DateTime.now().subtract(Duration(days: 3));
    return order.orderDate.year < dl.year ||
        order.orderDate.month < dl.month ||
        order.orderDate.day < dl.day;
  }

  bool _isAllWrote() {
    for(OrderItemResponse item in order.orderItems) {
      if(!item.reviewWrite) {
        return false;
      }
    }
    return true;
  }

  void _onCancel() {
    DialogUtils.dialogYesOrNo(Get.context, '주문을 취소 하시겠습니까?', onConfirm: (dialogContext) async {
      OrderInfoModel orderInfoModel = Get.context.read();
      if(orderInfoModel.isCanceling) return;

      try {
        orderInfoModel.changeIsCanceling(true);

        Get.back();
        await Get.context.read<OrderModel>().cancel(oIdx: order.idx);
        await Get.context.read<SignInModel>().renewUserInfo();
        await Get.context.read<OrderInfoModel>().fetchToday(isForceUpdate: true);
        ToastUtils.showToast(msg: '취소완료');

      } finally {
        orderInfoModel.changeIsCanceling(false);
      }
    });
  }

  bool _isValidCancel() {
    return order.orderType == OrderType.ORDER_READY || order.orderType == OrderType.ORDER_QUICK_READY;
  }

  void _signGuide() {
    // 로그인 유도
    if(Get.context.read<SignInModel>().isSignIn()) {
      _onReview();
    } else {
      showSignModal(predicateUrl: Get.currentRoute);
    }
  }

  void _onReview() {
    Set<int> idxItems = Set();
    Set<int> stores = Set();
    for(OrderItemResponse item in order.orderItems) {
      if(!item.reviewWrite) {
        stores.add(item.idxStore);
        idxItems.add(item.idx);
      }
    }
    if(stores.length > 1) {
      Get.to(StoreReviewSelectPage(order: order));
    } else {
      String nameProducts = '';
      for(int i=0; i<order.orderItems.length; i++) {
        OrderItemResponse item = order.orderItems[i];
        if(!item.reviewWrite) {
          nameProducts += '#${item.nameProduct}' + (i == order.orderItems.length - 1 ? '' : ' ');
        }
      }
      Get.to(StoreReviewWritePage(
        idxesOrderItem: idxItems.toList(),
        idxStore: stores.first,
        nameStore: order.orderItems.first.nameStore,
        nameProducts: nameProducts
      ));
    }
  }

  List<int> _idxesOrderItem() {

  }
}
