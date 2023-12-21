import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/common/refresh_load_more_indicator.dart';
import 'package:imitate_miyoushe/http/request.dart';
import 'package:imitate_miyoushe/common/loading.dart';
import 'package:imitate_miyoushe/controllers/global.dart';

enum TabBarType { topics, posts, wikis, users }

class SearchPageController extends GetxController
    with GetTickerProviderStateMixin {
  GlobalController globalController = Get.find();
  RxMap searchData = {}.obs;
  RxString keyword = ''.obs;
  late TabController tabController;
  RxInt currentTab = 0.obs;
  List tabBarList = [
    // {"name": "全部", "type": TabBarType.all},
    {"name": "话题", "type": TabBarType.topics},
    {"name": "帖子", "type": TabBarType.posts},
    {"name": "百科", "type": TabBarType.wikis},
    {"name": "用户", "type": TabBarType.users},
  ];

  Timer? timer;
  changeInput(value) {
    keyword.value = value;
    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 500), () {
      getCurrentData();
    });
  }

  RxMap<String, dynamic> tabBarData = {
    'topicsData': {},
    'topicsList': [],
    'postsData': {},
    'postsList': [],
    'wikisData': {},
    'wikisList': [],
    'usersData': {},
    'usersList': [],
  }.obs;
  Future<LoadingMoreState> getData(TabBarType key) async {
    if (tabBarData['${key.name}Data']?['is_last'] == true) {
      return LoadingMoreState.noData;
    }
    var params = {
      'gids': '${globalController.currentGameCategory['id']}',
      'keyword': keyword.value,
      'size': '20',
    };
    var url = '';
    switch (key) {
      case TabBarType.topics:
        params['type'] = '3';
        url = '/topic/wapi/searchTopic';
        break;
      case TabBarType.posts:
        params['type'] = '2';
        url = '/post/wapi/searchPosts';
        break;
      case TabBarType.wikis:
        params['type'] = '4';
        url = '/search/api/searchAllWiki';
        break;
      case TabBarType.users:
        params['type'] = '1';
        url = '/user/wapi/searchUser';
        break;
    }
    if (tabBarData['${key.name}Data']['last_id'] != null) {
      params['last_id'] = '${tabBarData['${key.name}Data']['last_id']}';
    }
    var res = await Request.requestGet(
      url,
      params: params,
    );
    tabBarData['${key.name}Data'] = res['data'];
    tabBarData['${key.name}List'].addAll(res['data'][key.name]);
    return LoadingMoreState.complete;
  }

  // 获取对应tabbar下的数据
  getCurrentData() async {
    TabBarType type = tabBarList[currentTab.value]['type'];
    tabBarData['topicsData'] = {};
    tabBarData['topicsList'] = [];
    tabBarData['postsData'] = {};
    tabBarData['postsList'] = [];
    tabBarData['wikisData'] = {};
    tabBarData['wikisList'] = [];
    tabBarData['usersData'] = {};
    tabBarData['usersList'] = [];
    Loading.showLoading();
    await getData(type);
    Loading.hideLoading();
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabBarList.length, vsync: this);
    tabController.addListener(() {
      if (tabController.animation?.value == tabController.index) {
        currentTab.value = tabController.index;
        getCurrentData();
      }
    });
  }
}
