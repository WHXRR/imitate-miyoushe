import 'package:get/get.dart';
import '../controllers/article_details.dart';

class ArticleDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ArticleDetailsController>(ArticleDetailsController());
  }
}
