import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/global.dart';
import 'package:imitate_miyoushe/http/request.dart';
import 'package:imitate_miyoushe/common/loading.dart';
import 'package:imitate_miyoushe/common/refresh_load_more_indicator.dart';

class HomeController extends GetxController {
  RxList homeDataPost = [].obs;
  RxList bannerData = [].obs;
  int _page = 1;
  GlobalController globalController = Get.find();

  Future<LoadingMoreState> getData() async {
    // 获取帖子数据
    var jsonResponse =
        await Request.requestGet('/apihub/wapi/webHome', params: {
      'gids': '${globalController.currentGameCategory['id']}',
      'page': '$_page',
      'page_size': '20'
    });
    var postIDs = List.from(jsonResponse['data']['recommended_posts'])
        .map((item) => item['post']['post_id'])
        .toList()
        .join(',');
    // 获取浏览、评论、点赞数据
    var articleData = await Request.requestGet('/post/wapi/getDynamicData',
        params: {
          'gids': '${globalController.currentGameCategory['id']}',
          'post_ids': postIDs
        });
    var _list = List.from(jsonResponse['data']['recommended_posts'])
        .asMap()
        .entries
        .map((item) {
      item.value['stat2'] = articleData['data']['list'][item.key]['stat'];
      return item.value;
    }).toList();
    homeDataPost.addAll(_list);
    bannerData.addAll(jsonResponse['data']['carousels']);
    Loading.hideLoading();
    return LoadingMoreState.complete;
  }

  Future<LoadingMoreState> getNextPageData() {
    _page++;
    return getData();
  }

  @override
  void onInit() {
    super.onInit();
    Loading.showLoading();
    getData();
  }
}
