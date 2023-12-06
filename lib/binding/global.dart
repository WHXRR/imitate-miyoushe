import 'package:get/get.dart';
import '../controllers/global.dart';

class GlobalBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<GlobalController>(GlobalController());
  }
}
