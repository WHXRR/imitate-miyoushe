import 'package:imitate_miyoushe/controllers/topics.dart';
import 'package:get/get.dart';

class TopicsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopicsController>(() => TopicsController());
  }
}
