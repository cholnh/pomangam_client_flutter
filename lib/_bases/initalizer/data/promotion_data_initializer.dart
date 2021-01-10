import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/util/log_utils.dart';
import 'package:pomangam_client_flutter/providers/promotion/promotion_model.dart';
import 'package:provider/provider.dart';

Future<bool> promotionDataInitialize({
  int dIdx
}) async
=> logProcess(
    name: 'promotionDataInitialize',
    function: () async {
      await Get.context.read<PromotionModel>().fetch(dIdx: dIdx);
      return true;
    }
);