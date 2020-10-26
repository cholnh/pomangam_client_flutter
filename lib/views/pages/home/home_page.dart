import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/key/pmg_key.dart';
import 'package:pomangam_client_flutter/domains/sort/sort_type.dart';
import 'package:pomangam_client_flutter/domains/tab/tab_menu.dart';
import 'package:pomangam_client_flutter/providers/advertisement/advertisement_model.dart';
import 'package:pomangam_client_flutter/providers/cart/cart_model.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client_flutter/providers/home/home_view_model.dart';
import 'package:pomangam_client_flutter/providers/order/time/order_time_model.dart';
import 'package:pomangam_client_flutter/providers/sort/home_sort_model.dart';
import 'package:pomangam_client_flutter/providers/store/store_summary_model.dart';
import 'package:pomangam_client_flutter/providers/tab/tab_model.dart';
import 'package:pomangam_client_flutter/views/pages/_bases/custom_refresher.dart';
import 'package:pomangam_client_flutter/views/pages/deliverysite/delivery_site_page.dart';
import 'package:pomangam_client_flutter/views/widgets/cart/cart_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/home/advertisement/home_advertisement_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/home/contents/home_contents_bar_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/home/contents/home_contents_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/home/home_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {

  final ScrollController scrollController;
  final PanelController controller;
  final Function onHelpTap;

  HomePage({this.scrollController, this.controller, this.onHelpTap});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {

  AppLifecycleState _notification = AppLifecycleState.detached;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool isPanelShown = false;

  StoreSummaryModel storeSummaryModel;
  int dIdx;
  int oIdx;
  DateTime oDate;
  SortType sortType;

  StreamController _streamController;
  StreamSubscription _streamSubscription;

  @override
  void initState() {

    WidgetsBinding.instance.addObserver(this);

    context.read<HomeViewModel>().changeIsCurrent(true);
    storeSummaryModel = context.read();
    DeliverySiteModel deliverySiteModel = context.read();
    OrderTimeModel orderTimeModel = context.read();

    _init(notify: false);
    _streamController = StreamController()
      ..addStream(Stream.periodic(
          Duration(seconds: 20), (_) {
            if(isAbleToFetch()) {
              if(orderTimeModel.isOverUserTime()) {
                _init();
              }
              return storeSummaryModel.fetchQuantityOrderable(
                  dIdx: deliverySiteModel.userDeliverySite?.idx,
                  oIdx: orderTimeModel.userOrderTime?.idx,
                  oDate: orderTimeModel.userOrderDate
              );
            }
          }
      ));
    _streamSubscription = _streamController.stream.listen(storeSummaryModel.setQuantityOrderable);
    super.initState();
  }

  bool isAbleToFetch() {
    bool isCurrent = Get?.currentRoute != null && Get.currentRoute == '/BasePage';
    bool isValidAppLifecycleState = _notification == AppLifecycleState.detached || _notification == AppLifecycleState.resumed;
    // print('isCurrent : $isCurrent // isValidAppLifecycleState : $isValidAppLifecycleState // ${Get.currentRoute == '/BasePage'} // ${context.read<HomeViewModel>().isCurrent}');
    return isCurrent && isValidAppLifecycleState && Get.context.read<HomeViewModel>().isCurrent;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() { _notification = state; });
  }

  @override
  void deactivate() {
    super.deactivate();
    if(ModalRoute.of(context).isCurrent && Provider.of<TabModel>(context).tab == TabMenu.home) {
      _streamSubscription.resume();
    } else {
      _streamSubscription.pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if(_streamController.isClosed) {
      _streamController.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isShowCart = (context.watch<CartModel>().cart?.items?.length ?? 0) != 0;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Scaffold(
              appBar: HomeAppBar(
                onTitleTap: _onTitleTap,
                onHelpTap: widget.onHelpTap
              ),
              // endDrawer: HomeDrawerWidget(),
              body: _body(isShowCart: isShowCart),
            ),
            CartWidget(controller: widget.controller)
          ],
        ),
      ),
    );
  }

  void _onTitleTap() {
    Get.to(DeliverySitePage(), transition: Transition.cupertino, duration: Duration.zero);
  }

  Widget _body({bool isShowCart = false}) {
    return SafeArea(
      child: CustomRefresher(
        controller: _refreshController,
        onLoading: _loading,
        onRefresh: _refresh,
        child: CustomScrollView(
          key: PmgKeys.deliveryPage,
          controller: widget.scrollController,
          slivers: <Widget>[
            HomeAdvertisementWidget(),
            HomeContentsBarWidget(
              onChangedTime: _onChangedTime,
              onChangedSort: _onChangedSort,
            ),
            HomeContentsWidget(),
            SliverToBoxAdapter(
              child: Container(height: isShowCart ? 55.0 : 0.0),
            )
          ]
        )
      )
    );
  }

  void _onChangedTime() {
    if(storeSummaryModel.hasReachedMax) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  void _onChangedSort() {
    if(storeSummaryModel.hasReachedMax) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  void _refresh() async{
    _refreshController.loadComplete();
    _init();
    _refreshController.refreshCompleted();
  }

  void _loading() async{
    if(storeSummaryModel.hasReachedMax) {
      _refreshController.loadNoData();
    } else {
      await storeSummaryModel.fetch(
        dIdx: dIdx,
        oIdx: oIdx,
        oDate: oDate,
        sortType: sortType
      );
      _refreshController.loadComplete();
    }
  }

  void _init({bool notify = true}) async {
    DeliverySiteModel deliverySiteModel = context.read();
    OrderTimeModel orderTimeModel = context.read();
    AdvertisementModel advertisementModel = context.read();
    HomeSortModel homeSortModel = context.read();
    CartModel cartModel = context.read();

    if(orderTimeModel.isOverUserTime()) {
      orderTimeModel.renewOrderableFirstTime(notify: notify);
    }
    cartModel.renewOrderableTime(notify: notify);

    // index
    dIdx = deliverySiteModel.userDeliverySite?.idx;
    oIdx = orderTimeModel.userOrderTime?.idx;
    oDate = orderTimeModel.userOrderDate;
    sortType = homeSortModel.sortType;

    // advertisement fetch
    advertisementModel
      ..clear(notify: notify)
      ..fetch(dIdx: dIdx);

    // store summary fetch
    storeSummaryModel.clear(notify: notify);
    await storeSummaryModel.fetch(
      isForceUpdate: true,
      dIdx: dIdx,
      oIdx: oIdx,
      oDate: oDate,
      sortType: sortType
    );

    // SmartRefresher 상태 초기화
    if(storeSummaryModel.hasReachedMax) {
      _refreshController.loadNoData();
    }
  }
}
