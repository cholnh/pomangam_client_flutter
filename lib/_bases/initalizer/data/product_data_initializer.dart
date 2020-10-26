import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/util/log_utils.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:provider/provider.dart';

Future<bool> productDataInitialize({
  int dIdx
}) async
=> logProcess(
    name: 'productDataInitialize',
    function: () async {
      Get.context.read<ProductModel>().loadUserRecentRequirement();
      return true;
    }
);