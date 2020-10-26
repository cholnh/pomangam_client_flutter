import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/util/log_utils.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/detail/delivery_detail_site_model.dart';
import 'package:provider/provider.dart';

Future<bool> deliveryDetailSiteDataInitialize({
  int dIdx,
  int ddIdx
}) async
=> logProcess(
    name: 'deliveryDetailSiteDataInitialize',
    function: () async {
      await Get.context.read<DeliveryDetailSiteModel>().changeUserDeliveryDetailSiteByIdx(dIdx: dIdx, ddIdx: ddIdx);
      return true;
    }
);