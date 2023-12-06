import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';

class Loading {
  static void showLoading([String? str]) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 20000)
      ..indicatorType = EasyLoadingIndicatorType.wave
      ..loadingStyle = EasyLoadingStyle.dark
      ..maskType = EasyLoadingMaskType.black;
    EasyLoading.show(status: str ?? '加载中...');
  }

  static void hideLoading() {
    EasyLoading.dismiss();
  }
}
