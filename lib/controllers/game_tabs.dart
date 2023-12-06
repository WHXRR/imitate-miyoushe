import 'package:flutter/material.dart';
import 'package:imitate_miyoushe/http/request.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/global.dart';

class GameTabsController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  late List categoryList;
  RxBool loadingCompleted = false.obs;
  RxInt currentTab = 0.obs;

  GlobalController globalController = Get.find();

  // 获取游戏分类
  void getGameTabs() async {
    loadingCompleted.value = false;
    var jsonResponse = await Request.requestGet(
        '/forum/wapi/getForumsByGameForPHP',
        params: {'gids': '${globalController.currentGameCategory['id']}'});
    if (jsonResponse['data']?['forumlists'] == null) return;
    List list = jsonResponse['data']['forumlists'];
    list.insert(0, {
      'id': '0',
      'name': '推荐',
    });
    categoryList = list;
    tabController = TabController(length: categoryList.length, vsync: this);
    tabController.addListener(() {
      if (tabController.animation?.value == tabController.index) {
        currentTab.value = tabController.index;
      }
    });
    loadingCompleted.value = true;
  }

  void retrieveGameData() {
    tabController.dispose();
    loadingCompleted.value = false;
    getGameTabs();
  }

  @override
  void onInit() {
    super.onInit();
    getGameTabs();
  }
}
