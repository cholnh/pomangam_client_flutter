import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/util/log_utils.dart';
import 'package:pomangam_client_flutter/domains/promotion/promotion.dart';
import 'package:pomangam_client_flutter/providers/cart/cart_model.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/detail/delivery_detail_site_model.dart';
import 'package:pomangam_client_flutter/providers/order/time/order_time_model.dart';
import 'package:pomangam_client_flutter/providers/promotion/promotion_model.dart';
import 'package:provider/provider.dart';

Future<bool> cartDataInitialize({
  String subAddr
}) async
=> logProcess(
    name: 'cartDataInitialize',
    function: () async {
      OrderTimeModel orderTimeModel = Get.context.read<OrderTimeModel>();
      DeliveryDetailSiteModel detailSiteModel = Get.context.read<DeliveryDetailSiteModel>();
      CartModel cartModel = Get.context.read<CartModel>();
      cartModel.clear();
      cartModel.cart
      ..orderDate = orderTimeModel.userOrderDate
      ..orderTime = orderTimeModel.userOrderTime
      ..detail = detailSiteModel.userDeliveryDetailSite
      ..subAddress = subAddr;

      List<Promotion> promotions = Get.context.read<PromotionModel>().promotions;
      cartModel.cart.usingPromotions
            ..clear()
            ..addAll(promotions);
      return true;
    }
);