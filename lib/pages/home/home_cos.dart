import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/common/keep_alive_wrapper.dart';
import 'package:imitate_miyoushe/http/request.dart';
import 'package:imitate_miyoushe/common/loading.dart';
import 'package:imitate_miyoushe/common/refresh_load_more_indicator.dart';
import 'package:imitate_miyoushe/controllers/global.dart';
import 'cos_ranking.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'cos_card.dart';
import 'package:imitate_miyoushe/router/routes.dart';

class HomeCos extends StatefulWidget {
  final Map currentTab;
  const HomeCos({Key? key, required this.currentTab}) : super(key: key);

  @override
  _HomeCosState createState() => _HomeCosState();
}

class _HomeCosState extends State<HomeCos> {
  Map<String, dynamic> postDataMap = {};
  List homeDataPost = [];
  GlobalController globalController = Get.find();

  Future<LoadingMoreState> getData() async {
    // 获取帖子数据
    var jsonResponse =
        await Request.requestGet('/post/wapi/getForumPostList', params: {
      'gids': '${globalController.currentGameCategory['id']}',
      'forum_id': '${widget.currentTab['id']}',
      'page_size': '20',
      'sort_type': '1',
      'is_good': 'false',
      'is_hot': 'false'
    });
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
    return KeepAliveWrapper(
      child: homeDataPost.isNotEmpty
          ? Container(
              color: const Color(0xfff2f4f5),
              child: RefreshLoadMoreIndicator(
                  itemCount: 1,
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
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          color: Colors.white,
                          child: CosRanking(
                            currentTab: widget.currentTab,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          color: Colors.white,
                          child: MasonryGridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: homeDataPost.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  MyRouter.push(
                                    MyRouter.articleDetails,
                                    {
                                      'id': homeDataPost[index]['post']
                                          ['post_id'],
                                      'showType':
                                          widget.currentTab['show_type'],
                                    },
                                  );
                                },
                                child: CosCard(
                                  cardData: homeDataPost[index],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }),
            )
          : Container(),
    );
  }
}
