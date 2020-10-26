import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:injector/injector.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pomangam_client_flutter/_bases/initalizer/initializer.dart';
import 'package:pomangam_client_flutter/_bases/util/toast_utils.dart';
import 'package:pomangam_client_flutter/providers/cart/cart_model.dart';
import 'package:pomangam_client_flutter/providers/order/order_info_model.dart';
import 'package:pomangam_client_flutter/providers/order/order_model.dart';
import 'package:pomangam_client_flutter/views/pages/_bases/base_page.dart';
import 'package:provider/provider.dart';
import 'package:pomangam_client_flutter/domains/deliverysite/delivery_site.dart';
import 'package:pomangam_client_flutter/domains/deliverysite/detail/delivery_detail_site.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/detail/delivery_detail_site_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/deliverysite/detail/delivery_detail_bottom_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/deliverysite/detail/delivery_detail_site_items_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/deliverysite/detail/delivery_detail_site_web_map_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomangam_client_flutter/_bases/key/shared_preference_key.dart' as s;

import 'delivery_detail_page_type.dart';

class DeliveryDetailSitePage extends StatefulWidget {

  final DeliverySite deliverySite;
  final int oIdx;

  DeliveryDetailSitePage(this.deliverySite, {this.oIdx = -1});

  @override
  _DeliveryDetailSitePageState createState() => _DeliveryDetailSitePageState();
}

class _DeliveryDetailSitePageState extends State<DeliveryDetailSitePage> {

  GlobalKey<GoogleMapStateBase> googleKey = GlobalKey<GoogleMapStateBase>();
  DeliveryDetailSiteModel detailSiteModel;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    detailSiteModel = context.read<DeliveryDetailSiteModel>();
    await detailSiteModel.fetch(
        dIdx: widget.deliverySite.idx,
        forceUpdate: true
    );
    if(detailSiteModel.deliveryDetailSites.isNotEmpty) {
      DeliveryDetailSite detailSite = detailSiteModel.deliveryDetailSites.first;
      detailSiteModel.changeSelected(detailSite);
      _changeCameraPosition(detailSite.latitude, detailSite.longitude);
      detailSiteModel.deliveryDetailSites.forEach((DeliveryDetailSite detailSite) {
        _makeMarker(detailSite.latitude, detailSite.longitude);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DeliverySiteModel>(
        builder: (_, model, __) {
          return ModalProgressHUD(
            inAsyncCall: model.isChanging,
            child: Scaffold(
              appBar: BasicAppBar(
                title: '${widget.deliverySite.name} 상세위치',
                leadingIcon: const Icon(CupertinoIcons.back, size: 20, color: Colors.black),
              ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    DeliveryDetailSiteWebMapWidget(googleKey: googleKey),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: DeliveryDetailSiteItemsWidget(googleKey: googleKey, dIdx: widget.deliverySite.idx)
                      )
                    ),
                    Consumer<DeliveryDetailSiteModel>(
                      builder: (_, detailModel, __) {
                        if(detailModel.isFetching) {
                          return Container();
                        }
                        return  DeliveryDetailBottomBar(
                          centerText: '적용',
                          isActive: !model.isChanging,
                          onSelected: _change // () => Get.to(DeliveryDetailSiteSubAddressPage(widget.deliverySite, detailModel.selected), duration: Duration.zero),
                        );
                      }
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  void _makeMarker(double lat, double lng) {
    GoogleMap.of(googleKey).addMarker(Marker(
      GeoCoord(lat, lng),
    ));
  }

  void _changeCameraPosition(double lat, double lng) async {
    double c = 0.0009;
    GoogleMap.of(googleKey).moveCamera(GeoCoordBounds(
      northeast: GeoCoord(lat+c, lng+c),
      southwest: GeoCoord(lat-c, lng-c),
    ), padding: 0, animated: true);
  }

  void _change() async {
    DeliveryDetailPageType pageType = Get.arguments ?? DeliveryDetailPageType.FROM_DEFAULT;

    DeliverySiteModel deliverySiteModel = context.read();
    DeliveryDetailSiteModel detailSiteModel = context.read();
    CartModel cartModel = context.read();

    try {
      bool isSuccess = true;
      deliverySiteModel.changeIsChanging(true);

      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setInt(s.idxDeliverySite, widget.deliverySite.idx);
      pref.setInt(s.idxDeliveryDetailSite, detailSiteModel.selected.idx);

      deliverySiteModel.changeUserDeliverySite(widget.deliverySite);
      detailSiteModel.changeUserDeliveryDetailSite(detailSiteModel.selected);
      cartModel.cart.detail = detailSiteModel.selected;

      if(pageType == DeliveryDetailPageType.FROM_CART) {
        Get.back();
      } else if(pageType == DeliveryDetailPageType.FROM_ORDER_INFO) {
        if(widget.oIdx != -1) {
          isSuccess = await context.read<OrderModel>().patchDetailSite(
            oIdx: widget.oIdx,
            ddIdx: detailSiteModel.selected.idx
          );
          if(isSuccess) {
            context.read<OrderInfoModel>().fetchToday(isForceUpdate: true);
          }
        }
        Get.back();
      } else {
        Initializer _initializer = Injector.appInstance.getDependency<Initializer>();
        await _initializer.initializeModelData();
        Get.offAll(BasePage(), transition: Transition.cupertino);
      }

      // toast 메시지
      ToastUtils.showToast(
        msg: isSuccess
            ? '적용완료'
            : '적용실패',
      );
    } finally {
      deliverySiteModel.changeIsChanging(false);
    }
  }
}
