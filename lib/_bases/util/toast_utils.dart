import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static void showToast({String msg = '적응완료'}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        webPosition: 'center',
        webBgColor: 'linear-gradient(to right, #000000, #000000)',
        timeInSecForIosWeb: 1,
        webShowClose: true,
        fontSize: 13.0,
    );
  }
}
