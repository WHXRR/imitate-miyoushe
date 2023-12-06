import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './router/routes.dart';
import 'package:imitate_miyoushe/binding/global.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    defaultTransition: Transition.rightToLeft,
    getPages: MyRouter.routes,
    initialRoute: MyRouter.home,
    initialBinding: GlobalBinding(),
    builder: EasyLoading.init(),
  ));
}
