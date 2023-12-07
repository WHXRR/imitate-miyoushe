import 'package:get/get.dart';
import 'package:imitate_miyoushe/http/request.dart';
import 'package:imitate_miyoushe/controllers/global.dart';
import 'package:imitate_miyoushe/common/loading.dart';

class ArticleDetailsController extends GetxController {
  GlobalController globalController = Get.find();

  RxBool loadingCompleted = false.obs;
  RxMap articleData = {}.obs;
  RxBool onlyMaster = false.obs;
  RxInt orderType = 0.obs;
  RxMap commentData = {}.obs;
  RxList commentList = [].obs;

  // 获取文章详情
  Future getArticleData() {
    return Request.requestGet('/post/wapi/getPostFull', params: {
      'gids': '${globalController.currentGameCategory['id']}',
      'read': '1',
      'post_id': Get.arguments['id'],
    });
  }

  Future getArticleComments() {
    var params = {
      'gids': '${globalController.currentGameCategory['id']}',
      'post_id': Get.arguments['id'],
      'size': '20',
      'only_master': '${onlyMaster.value}',
      'is_hot': '${orderType.value == 0}',
    };
    if (orderType.value != 0) {
      params['order_type'] = '${orderType.value}';
    } else {
      if (onlyMaster.value) {
        params['order_type'] = '1';
        params['is_hot'] = 'false';
      }
    }
    if (commentData['is_last'] != null && !commentData['is_last']) {
      params['last_id'] = commentData['last_id'];
    }
    return Request.requestGet('/post/wapi/getPostReplies', params: params);
  }

  void getComments() async {
    commentData.value = {};
    commentList.value = [];
    var res1 = await getArticleComments();
    commentData.value = res1['data'];
    commentList.value = res1['data']['list'];
  }

  void getData() async {
    Loading.showLoading();
    articleData.value = {};
    commentData.value = {};
    commentList.value = [];
    loadingCompleted.value = false;
    var res1 = await getArticleData();
    var res2 = await getArticleComments();
    articleData.value = res1['data']['post'];
    commentData.value = res2['data'];
    commentList.value = res2['data']['list'];
    loadingCompleted.value = true;
    Loading.hideLoading();
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }
}
