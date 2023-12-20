import 'package:flutter/material.dart';
import '../article/home_article.dart';
import 'package:imitate_miyoushe/common/keep_alive_wrapper.dart';
import 'package:imitate_miyoushe/http/request.dart';
import 'package:imitate_miyoushe/common/loading.dart';
import 'package:imitate_miyoushe/common/refresh_load_more_indicator.dart';
import 'package:get/get.dart';
import 'home_sort.dart';
import 'package:imitate_miyoushe/controllers/global.dart';

class HomeOther extends StatefulWidget {
  final Map currentTab;
  const HomeOther({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  @override
  _HomeOtherState createState() => _HomeOtherState();
}

class _HomeOtherState extends State<HomeOther> {
  Map<String, dynamic> postDataMap = {};
  List homeDataPost = [];
  GlobalController globalController = Get.find();
  bool isHot = false;
  int sortType = 1;

  Future<LoadingMoreState> getData() async {
    // 获取帖子数据
    var params = {
      'gids': '${globalController.currentGameCategory['id']}',
      'forum_id': '${widget.currentTab['id']}',
      'page_size': '20',
      'sort_type': '$sortType',
      'is_good': 'false',
      'is_hot': '$isHot'
    };
    var jsonResponse =
        await Request.requestGet('/post/wapi/getForumPostList', params: params);
    setState(() {
      postDataMap = jsonResponse['data'];
      homeDataPost = jsonResponse['data']['list'];
    });
    Loading.hideLoading();
    return LoadingMoreState.complete;
  }

  Future<LoadingMoreState> getNextPageData() async {
    if (postDataMap['is_last']) {
      return LoadingMoreState.noData;
    } else {
      // 获取帖子数据
      var jsonResponse =
          await Request.requestGet('/post/wapi/getForumPostList', params: {
        'gids': '${globalController.currentGameCategory['id']}',
        'forum_id': '${widget.currentTab['id']}',
        'last_id': '${postDataMap['last_id']}',
        'page_size': '10',
        'sort_type': '1',
        'is_good': 'false',
        'is_hot': 'false',
      });
      setState(() {
        postDataMap = jsonResponse['data'];
        homeDataPost.addAll(jsonResponse['data']['list']);
      });
      return LoadingMoreState.complete;
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Loading.showLoading();
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfff2f4f5),
      child: KeepAliveWrapper(
        child: RefreshLoadMoreIndicator(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                HomeSort(
                    isHot: isHot,
                    sortType: sortType,
                    cb: (hot, type) async {
                      setState(() {
                        isHot = hot;
                        sortType = type;
                        postDataMap = {};
                        homeDataPost = [];
                      });
                      await getData();
                    }),
                Column(
                  children: homeDataPost.isNotEmpty
                      ? homeDataPost.map((item) {
                          return HomeArticle(
                            itemData: item,
                          );
                        }).toList()
                      : [],
                )
              ],
            );
          },
          onRefresh: () async {
            setState(() {
              postDataMap = {};
              homeDataPost = [];
            });
            await getData();
          },
          onLoadMore: () {
            return getNextPageData();
          },
        ),
      ),
    );
  }
}
