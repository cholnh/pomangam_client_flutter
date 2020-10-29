import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/util/log_utils.dart';
import 'package:pomangam_client_flutter/providers/order/order_info_model.dart';
import 'package:provider/provider.dart';

Future<bool> orderDataInitialize() async
=> logProcess(
    name: 'orderDataInitialize',
    function: () async {
      OrderInfoModel orderInfoModel = Get.context.read<OrderInfoModel>();
      await orderInfoModel.countToday();
      return true;
    }
);