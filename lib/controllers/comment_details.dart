import 'package:get/get.dart';
import 'package:imitate_miyoushe/http/request.dart';
import 'package:imitate_miyoushe/controllers/global.dart';
import 'package:imitate_miyoushe/controllers/article_details.dart';
import 'package:imitate_miyoushe/common/loading.dart';
import 'package:imitate_miyoushe/common/refresh_load_more_indicator.dart';

class CommentDetailsController extends GetxController {
  final globalController = Get.find<GlobalController>();
  final articleDetailsController = Get.find<ArticleDetailsController>();

  var commentData = {}.obs;
  var oldCommentData = {}.obs;
  var commentList = [].obs;

  // 获取详情
  Future getCommentData() {
    var params = {
      'gids': '${globalController.currentGameCategory['id']}',
      'post_id': articleDetailsController.articleData['post']['post_id'],
      'floor_id': '${Get.arguments['floor_id']}',
      'size': '20',
    };
    if (commentData['last_id'] != null) {
      params['last_id'] = commentData['last_id'];
    }
    return Request.requestGet('/post/wapi/getSubReplies', params: params);
  }

  // 获取原评论内容
  Future getOldCommentData() {
    return Request.requestGet('/post/wapi/getRootReplyInfo', params: {
      'gids': '${globalController.currentGameCategory['id']}',
      'post_id': articleDetailsController.articleData['post']['post_id'],
      'reply_id': '${Get.arguments['reply_id']}',
    });
  }

  void getData() async {
    Loading.showLoading();
    commentData.value = {};
    oldCommentData.value = {};
    commentList.value = [];
    var res = await getCommentData();
    var res2 = await getOldCommentData();
    commentData.value = res['data'];
    commentList.value = res['data']['list'];
    oldCommentData.value = res2['data'];
    Loading.hideLoading();
  }

  Future<LoadingMoreState> getNextPage() async {
    if (commentData['is_last']) {
      return LoadingMoreState.noData;
    } else {
      var res = await getCommentData();
      commentData.value = res['data'];
      commentList.addAll(res['data']['list']);
      return LoadingMoreState.complete;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }
}
