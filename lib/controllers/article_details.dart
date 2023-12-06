import 'package:get/get.dart';
import 'package:imitate_miyoushe/http/request.dart';
import 'package:imitate_miyoushe/controllers/global.dart';
import 'package:imitate_miyoushe/common/loading.dart';

class ArticleDetailsController extends GetxController {
  GlobalController globalController = Get.find();

  RxBool loadingCompleted = false.obs;
  RxMap articleData = {}.obs;

  // 获取文章详情
  void getArticleData() async {
    var jsonResponse =
        await Request.requestGet('/post/wapi/getPostFull', params: {
      'gids': '${globalController.currentGameCategory['id']}',
      'read': '1',
      'post_id': Get.arguments['id'],
    });
    articleData.value = jsonResponse['data']['post'];
    loadingCompleted.value = true;
    Loading.hideLoading();
  }

  @override
  void onInit() {
    super.onInit();
    Loading.showLoading();
    getArticleData();
  }
}
