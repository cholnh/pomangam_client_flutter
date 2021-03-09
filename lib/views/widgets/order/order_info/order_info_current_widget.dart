import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/domains/order/order_response.dart';
import 'package:pomangam_client_flutter/providers/order/order_info_model.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/views/pages/_bases/custom_refresher.dart';
import 'package:pomangam_client_flutter/views/pages/order/order_info/order_info_page_type.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_divider.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:pomangam_client_flutter/views/widgets/order/order_info/item2/order_item_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderInfoCurrentWidget extends StatefulWidget {

  @override
  _OrderInfoCurrentWidgetState createState() => _OrderInfoCurrentWidgetState();
}

class _OrderInfoCurrentWidgetState extends State<OrderInfoCurrentWidget> {

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    //_refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OrderInfoModel orderInfoModel = context.watch();
    if(orderInfoModel.isFetching) return _shimmerWidget();
    return _itemsWidget(orderInfoModel.todayOrders);
  }

  Widget _shimmerWidget() {
    int r = Random().nextInt(4) + 1;
    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(r, (index) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomShimmer(height: 23, width: 40),
                              SizedBox(width: 10),
                              CustomShimmer(height: 10, width: 100),
                            ],
                          ),
                        ),
                        CustomShimmer(height: 10, width: 70),
                      ],
                    ),
                    SizedBox(height: 10),
                    CustomShimmer(height: 20, width: 150),
                    SizedBox(height: 5),
                    CustomShimmer(height: 18, width: 110),
                  ],
                ),
              ),
              CustomDivider()
            ],
          )),
        ),
      ),
    );
  }

  Widget _emptyWidget() {
    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
          child: Text('주문내역이 없습니다.')
      ),
    );
  }

  Widget _itemsWidget(List<OrderResponse> orders) {
    return CustomRefresher(
      controller: _refreshController,
      onLoading: _loading,
      onRefresh: _refresh,
      child:
        kIsWeb && !context.watch<SignInModel>().isSignIn()
        ? _webGuestWidget()
        : orders.isEmpty
            ? _emptyWidget()
            : SingleChildScrollView(
            child: Column(
                children: orders.map<Widget>((order) {
                  return OrderItemWidget(order: order, pageType: OrderInfoPageType.CURRENT);
                }).toList()..add(SizedBox(height: 50))
            )
        )
    );
  }

  Widget _webGuestWidget() {
    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
          child: Column(
            children: [
              Text('비회원은 주문내역 조회가 불가능합니다.'),
              Text('로그인 또는 어플리케이션을 이용해주세요.'),
            ],
          )
      ),
    );
  }

  Future<void> _refresh() async {
    _refreshController.loadComplete();
    context.read<OrderInfoModel>().clear(notify: false);
    await _loading(isForceUpdate: true);
    _refreshController.refreshCompleted();
  }

  Future<void> _loading({bool isForceUpdate = false}) async {
    OrderInfoModel orderInfoModel = context.read();
    if(orderInfoModel.hasNext) {
      await orderInfoModel.fetchToday(isForceUpdate: isForceUpdate);
      _refreshController.loadComplete();
    } else {
      _refreshController.loadComplete();
      _refreshController.loadNoData();
    }
  }
}

