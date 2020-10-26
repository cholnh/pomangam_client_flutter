import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/domains/order/order_response.dart';
import 'package:pomangam_client_flutter/providers/order/order_info_model.dart';
import 'package:pomangam_client_flutter/views/pages/_bases/custom_refresher.dart';
import 'package:pomangam_client_flutter/views/pages/order/order_info/order_info_page_type.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_divider.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:pomangam_client_flutter/views/widgets/order/order_info/item2/order_item_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderInfoHistoryWidget extends StatefulWidget {
  @override
  _OrderInfoHistoryWidgetState createState() => _OrderInfoHistoryWidgetState();
}

class _OrderInfoHistoryWidgetState extends State<OrderInfoHistoryWidget> {

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OrderInfoModel orderInfoModel = context.watch();
    if(orderInfoModel.isFetching) return _shimmerWidget();
    if(orderInfoModel.allOrders.isEmpty) return _emptyWidget();
    return _itemsWidget(orderInfoModel.allOrders);
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
                              const SizedBox(width: 10),
                              CustomShimmer(height: 10, width: 100),
                            ],
                          ),
                        ),
                        CustomShimmer(height: 10, width: 70),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomShimmer(height: 20, width: 150),
                    const SizedBox(height: 5),
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
      child: SingleChildScrollView(
        child: Column(
          children: orders.map<Widget>((order) {
            return OrderItemWidget(order: order, pageType: OrderInfoPageType.HISTORY);
          }).toList()..add(SizedBox(height: 50))
        )
      ),
    );
  }

  Future<void> _refresh() async {
    _refreshController.loadComplete();
    context.read<OrderInfoModel>().clearAll(notify: false);
    await _loading(isForceUpdate: true);
    _refreshController.refreshCompleted();
  }

  Future<void> _loading({bool isForceUpdate = false}) async {
    OrderInfoModel orderInfoModel = context.read();
    if(orderInfoModel.hasNext) {
      await orderInfoModel.fetchAll(isForceUpdate: isForceUpdate);
      _refreshController.loadComplete();
    } else {
      _refreshController.loadComplete();
      _refreshController.loadNoData();
    }
  }
}
