import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/util/log_utils.dart';
import 'package:pomangam_client_flutter/providers/coupon/coupon_model.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:provider/provider.dart';

Future<bool> couponDataInitialize({
  int dIdx
}) async
=> logProcess(
    name: 'couponDataInitialize',
    function: () async {
      if(Get.context.read<SignInModel>().isSignIn()) {
        CouponModel couponModel = Get.context.read<CouponModel>()
        ..clear();
        await couponModel.fetchAll();
      }
      return true;
    }
);