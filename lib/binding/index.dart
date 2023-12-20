import 'package:get/get.dart';
import '../controllers/game_tabs.dart';
import '../controllers/home.dart';

class IndexBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameTabsController>(() => GameTabsController());
    Get.put<HomeController>(HomeController());
    // Get.lazyPut<HomeController>(() => HomeController());
  }
}
