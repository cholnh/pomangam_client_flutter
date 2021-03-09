import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/_bases/key/pmg_key.dart';
import 'package:pomangam_client_flutter/providers/cart/cart_model.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client_flutter/providers/product/product_summary_model.dart';
import 'package:pomangam_client_flutter/providers/store/store_model.dart';
import 'package:pomangam_client_flutter/providers/store/store_product_category_model.dart';
import 'package:pomangam_client_flutter/providers/store/store_view_model.dart';
import 'package:pomangam_client_flutter/views/pages/_bases/custom_refresher.dart';
import 'package:pomangam_client_flutter/views/widgets/cart/cart_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/store/store_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/store/store_carte_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/store/store_center_button_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/store/store_description_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/store/store_header_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/store/store_product_category_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/store/store_product_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/store/store_story_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class StorePage extends StatefulWidget {

  final int sIdx;
  final bool isOrderable;

  StorePage({this.sIdx, this.isOrderable});

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {

  final PanelController _panelController = PanelController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool isPanelShown = false;

  @override
  void initState() {
    super.initState();
    StoreViewModel storeViewModel = Provider.of<StoreViewModel>(context, listen: false)
    ..isWidgetBuild = false;
    WidgetsBinding.instance.addPostFrameCallback((_)
      => storeViewModel.widgetBuild(notify: true));
    _init(notify: false);
  }

  @override
  Widget build(BuildContext context) {
    CartModel cartModel = context.watch<CartModel>();
    bool isShowCart = (cartModel.cart?.items?.length ?? 0) != 0;
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          WillPopScope(
            onWillPop: () async {
              if(isShowCart && _panelController.isPanelOpen) {
                _panelController.close();
                return Future.value(false);
              }
              return Future.value(true);
            },
            child: Scaffold(
              appBar: StoreAppBar(),
              body: _body(isShowCart: isShowCart),
            ),
          ),
          CartWidget(controller: _panelController)
        ],
      ),
    );
  }

  Widget _body({bool isShowCart = false}) {
    return SafeArea(
      child: CustomRefresher(
        controller: _refreshController,
        onLoading: _loading,
        onRefresh: _refresh,
        child: CustomScrollView(
          key: PmgKeys.storePage,
          slivers: <Widget>[
            StoreHeaderWidget(), // desc
            Consumer<StoreModel>(
              builder: (_, model, __) {
                if(widget.sIdx != 1 || model.isStoreDescriptionOpened) {
                  return StoreDescriptionWidget();  // Todo. 임시로 하드코딩 (추후변경)
                }
                return SliverToBoxAdapter(child: Container());
              },
            ),
            StoreCenterButtonWidget(),
            if(widget.sIdx != 1)  // Todo. 임시로 하드코딩 (추후변경)
              StoreStoryWidget()
            else
              StoreCarteWidget(),
            StoreProductCategoryWidget(
                sIdx: widget.sIdx,
                onChangedCategory: _onChangedCategory
            ),
            StoreProductWidget(isOrderable: widget.isOrderable),
            SliverToBoxAdapter(
              child: Container(height: isShowCart ? 55.0 : 0.0),
            )
          ],
        ),
      )
    );
  }

  void _init({bool notify = true}) async {
    StoreModel storeModel = context.read();
    ProductSummaryModel productSummaryModel = context.read();

    // delivery site index
    int dIdx = context.read<DeliverySiteModel>().userDeliverySite?.idx;

    // store category
    context.read<StoreProductCategoryModel>().clear(notify: notify);

    // store fetch
    storeModel
    ..clear(notify: notify)
    ..fetch(
      dIdx: dIdx,
      sIdx: widget.sIdx,
    );

    // products fetch
    productSummaryModel
    ..clear(notify: notify)
    ..fetch(
      isForceUpdate: true,
      dIdx: dIdx,
      sIdx: widget.sIdx
    ).then((res) {
      // SmartRefresher 상태 초기화
      if(productSummaryModel.hasReachedMax) {
        _refreshController.loadNoData();
      }
    });

    isPanelShown = false;
  }

  void _onChangedCategory() {
    ProductSummaryModel productSummaryModel = Provider.of<ProductSummaryModel>(context, listen: false);
    if(productSummaryModel.hasReachedMax) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  void _refresh() async {
    _refreshController.loadComplete();
    _init();
    _refreshController.refreshCompleted();
  }

  void _loading() async {
    ProductSummaryModel productSummaryModel = Provider.of<ProductSummaryModel>(context, listen: false);

    if(productSummaryModel.hasReachedMax) {
      _refreshController.loadNoData();
    } else {
      DeliverySiteModel deliverySiteModel = Provider.of<DeliverySiteModel>(context, listen: false);
      int dIdx = deliverySiteModel.userDeliverySite?.idx;
      int cIdx = Provider.of<StoreProductCategoryModel>(context, listen: false)
          .idxProductCategory;

      await productSummaryModel.fetch(
        isForceUpdate: true,
        dIdx: dIdx,
        sIdx: widget.sIdx,
        cIdx: cIdx
      );
      _refreshController.loadComplete();
    }
  }
}
