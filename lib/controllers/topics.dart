import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/global.dart';
import 'package:imitate_miyoushe/common/refresh_load_more_indicator.dart';
import 'package:imitate_miyoushe/http/request.dart';
import 'package:imitate_miyoushe/common/loading.dart';

class TopicsController extends GetxController {
  GlobalController globalController = Get.find();
  RxMap topicsInfo = {}.obs;
  RxMap topicsData = {}.obs;
  RxList topicsList = [].obs;
  RxInt listType = 0.obs;
  RxInt currentGameID = 0.obs;

  getTopicsInfo() async {
    var res = await Request.requestGet(
      '/topic/api/getTopicFullInfo',
      params: {
        'gids': '${globalController.currentGameCategory['id']}',
        'id': '${Get.arguments['id']}',
      },
    );
    topicsInfo.value = res['data'];
    currentGameID.value = globalController.currentGameCategory['id'];
  }

  Future<LoadingMoreState> getTopicsData() async {
    var params = {
      'gids': '${globalController.currentGameCategory['id']}',
      'topic_id': '${Get.arguments['id']}',
      'list_type': '${listType.value}',
      'page_size': '20',
      'game_id': '${currentGameID.value}',
    };
    if (topicsData['last_id'] != null) {
      params['last_id'] = topicsData['last_id'];
    }
    var res = await Request.requestGet(
      '/post/wapi/getTopicPostList',
      params: params,
    );
    topicsData.value = res['data'];
    topicsList.addAll(res['data']['posts']);
    return LoadingMoreState.complete;
  }

  @override
  void onInit() async {
    super.onInit();
    Loading.showLoading();
    await getTopicsInfo();
    await getTopicsData();
    Loading.hideLoading();
  }
}
