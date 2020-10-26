import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/util/log_utils.dart';
import 'package:pomangam_client_flutter/providers/order/time/order_time_model.dart';
import 'package:provider/provider.dart';

Future<bool> orderTimeDataInitialize({
  int dIdx
}) async
=> logProcess(
    name: 'orderTimeDataInitialize',
    function: () async {
      OrderTimeModel orderTimeModel = Get.context.read<OrderTimeModel>();
      await orderTimeModel.fetch(forceUpdate: true, dIdx: dIdx);
      return true;
    }
);