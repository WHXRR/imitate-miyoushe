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
import 'home_sort.dart';

class HomeCos extends StatefulWidget {
  final Map currentTab;
  const HomeCos({Key? key, required this.currentTab}) : super(key: key);

  @override
  _HomeCosState createState() => _HomeCosState();
}

class _HomeCosState extends State<HomeCos> {
  Map<String, dynamic> postDataMap = {};
  List homeDataPost = [];
  bool isHot = false;
  int sortType = 1;
  GlobalController globalController = Get.find();

  Future<LoadingMoreState> getData() async {
    if (postDataMap['is_last'] != null && postDataMap['is_last']) {
      return LoadingMoreState.noData;
    }
    var params = {
      'gids': '${globalController.currentGameCategory['id']}',
      'forum_id': '${widget.currentTab['id']}',
      'page_size': '20',
      'sort_type': '$sortType',
      'is_good': 'false',
      'is_hot': '$isHot',
    };
    if (postDataMap['last_id'] != null) {
      params['last_id'] = '${postDataMap['last_id']}';
    }
    print(params);
    // 获取帖子数据
    var res =
        await Request.requestGet('/post/wapi/getForumPostList', params: params);
    setState(() {
      postDataMap = res['data'];
      homeDataPost.addAll(res['data']['list']);
    });
    Loading.hideLoading();
    return LoadingMoreState.complete;
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
                    return getData();
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CosRanking(
                          currentTab: widget.currentTab,
                        ),
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
                          },
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
                              return CosCard(
                                cardData: homeDataPost[index],
                                currentTab: widget.currentTab,
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
