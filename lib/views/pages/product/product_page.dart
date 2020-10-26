import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/domains/product/product_type.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client_flutter/providers/order/time/order_time_model.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/providers/product/sub/product_sub_category_model.dart';
import 'package:pomangam_client_flutter/providers/store/store_model.dart';
import 'package:pomangam_client_flutter/views/widgets/product/product_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/product/product_body_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/product/requirement/collapsed/requirement_collapsed_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/product/requirement/panel/requirement_widget.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductPage extends StatefulWidget {

  final int pIdx;
  final ProductType type;

  ProductPage({this.pIdx, this.type});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  final PanelController _panelController = PanelController();
  bool isPanelShown = false;

  @override
  void initState() {
    _init(notify: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print('${MediaQuery.of(context).size.width}');

    ProductModel productModel = context.watch();

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Scaffold(
                appBar: ProductAppBar(),
                body: ProductBodyWidget(type: widget.type),
              ),
              SlidingUpPanel(
                controller: _panelController,
                minHeight: 80.0,
                maxHeight:
                  productModel.userRecentRequirement == null ||
                  productModel.userRecentRequirement.trim().isEmpty
                    ? 220
                    : 250,
                backdropEnabled: true,
                renderPanelSheet: false,
                onPanelOpened: _onSlideOpen,
                onPanelClosed: _onSlideClose,
                panel: RequirementWidget(),
                collapsed: RequirementCollapsedWidget(onSelected: _onSlideSelected)
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _init({bool notify = true}) async {
    context.read<ProductSubCategoryModel>().clear(notify: notify);

    // product fetch
    context.read<ProductModel>()
      ..clear(notify: notify)
      ..fetch(
        dIdx: context.read<DeliverySiteModel>().userDeliverySite?.idx,
        sIdx: context.read<StoreModel>().store.idx,
        pIdx: widget.pIdx
      )
      ..setQuantityOrderable(
        dIdx: context.read<DeliverySiteModel>().userDeliverySite?.idx,
        oIdx: context.read<OrderTimeModel>().userOrderTime?.idx,
        oDate: context.read<OrderTimeModel>().userOrderDate,
        sIdx: context.read<StoreModel>().store.idx
      );
  }

  Future<bool> _onWillPop() async {
    if(_panelController.isPanelOpen) {
      _panelController.close();
      return Future.value(false);
    }
    return Future.value(true);
  }

  void _onSlideSelected() {
    _panelController.open();
  }

  void _onSlideOpen() {
    if(isPanelShown) return;
    isPanelShown = true;
  }

  void _onSlideClose() {
    isPanelShown = false;
    FocusScope.of(context).unfocus();
  }
}