import 'package:get/get.dart';
import '../controllers/comment_details.dart';

class CommentDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentDetailsController>(() => CommentDetailsController());
  }
}
