import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/global.dart';
import 'package:imitate_miyoushe/common/refresh_load_more_indicator.dart';
import 'package:imitate_miyoushe/http/request.dart';
import 'package:imitate_miyoushe/common/loading.dart';

enum UserListType {
  userPost,
  userReply,
  userFavouritePost,
}

class UserController extends GetxController {
  GlobalController globalController = Get.find();
  RxMap userInfo = {}.obs;

  getUserInfo() async {
    var res = await Request.requestGet(
      '/user/wapi/getUserFullInfo',
      params: {
        'gids': '${globalController.currentGameCategory['id']}',
        'uid': Get.arguments['id'],
      },
    );
    userInfo.value = res['data'];
  }

  RxInt listType = 0.obs;
  RxMap<String, dynamic> userData = {
    'userPostData': {},
    'userPostList': [],
    'userReplyData': {},
    'userReplyList': [],
    'userFavouritePostData': {},
    'userFavouritePostList': [],
  }.obs;
  Future<LoadingMoreState> getData(UserListType type,
      {bool isChangeTabs = true}) async {
    if (isChangeTabs) {
      if (userData['${type.name}Data']?['list'] != null) {
        return LoadingMoreState.complete;
      }
    }
    if (userData['${type.name}Data']?['is_last'] != null &&
        userData['${type.name}Data']['is_last']) {
      return LoadingMoreState.noData;
    }
    var url = '/post/wapi/${type.name}';
    var params = {
      'size': '20',
      'uid': Get.arguments['id'],
    };
    if (userData['${type.name}Data']?['next_offset'] != null) {
      params['offset'] = userData['${type.name}Data']['next_offset'];
    }
    var res = await Request.requestGet(
      url,
      params: params,
    );
    if (res['data'] == null) {
      userData['${type.name}Data'] = {'isNull': true};
      userData['${type.name}List'].addAll([]);
    } else {
      userData['${type.name}Data'] = res['data'];
      userData['${type.name}List'].addAll(res['data']?['list'] ?? []);
    }
    return LoadingMoreState.complete;
  }

  @override
  void onInit() async {
    super.onInit();
    Loading.showLoading();
    await getUserInfo();
    await getData(UserListType.userPost);
    Loading.hideLoading();
  }
}
