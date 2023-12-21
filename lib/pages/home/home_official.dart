import 'package:flutter/material.dart';
import 'package:imitate_miyoushe/common/keep_alive_wrapper.dart';
import 'package:imitate_miyoushe/http/request.dart';
import 'package:imitate_miyoushe/common/loading.dart';
import 'package:imitate_miyoushe/common/refresh_load_more_indicator.dart';
import 'package:get/get.dart';
import 'home_official_card1.dart';
import 'home_official_card2.dart';
import 'package:imitate_miyoushe/controllers/global.dart';

class HomeOfficial extends StatefulWidget {
  final Map currentTab;
  const HomeOfficial({Key? key, required this.currentTab}) : super(key: key);

  @override
  _HomeOfficialState createState() => _HomeOfficialState();
}

class _HomeOfficialState extends State<HomeOfficial> {
  GlobalController globalController = Get.find();
  Map postDataMap = {};
  List homeDataPost = [];
  int sortType = 2;
  Future<LoadingMoreState> getData() async {
    if (postDataMap['is_last'] != null && postDataMap['is_last']) {
      return LoadingMoreState.noData;
    }
    // 获取帖子数据
    var params = {
      'gids': '${globalController.currentGameCategory['id']}',
      'page_size': '20',
      'type': '$sortType',
    };
    if (postDataMap['last_id'] != null) {
      params['last_id'] = '${postDataMap['last_id']}';
    }
    Loading.showLoading();
    var jsonResponse =
        await Request.requestGet('/post/wapi/getNewsList', params: params);
    setState(() {
      postDataMap = jsonResponse['data'];
      homeDataPost.addAll(jsonResponse['data']['list']);
    });
    Loading.hideLoading();
    return LoadingMoreState.complete;
  }

  List sortList = [
    {
      'name': '活动',
      'type': 2,
    },
    {
      'name': '公告',
      'type': 1,
    },
    {
      'name': '资讯',
      'type': 3,
    }
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
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
            return Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Color(0xffebeff0),
                    ))),
                    child: Row(
                      children: sortList
                          .map(
                            (item) => InkWell(
                              onTap: () {
                                setState(() {
                                  if (sortType == item['type']) return;
                                  sortType = item['type'];
                                  postDataMap = {};
                                  homeDataPost = [];
                                  getData();
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  color: sortType == item['type']
                                      ? const Color(0xfff2f4f5)
                                      : Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(23)),
                                ),
                                padding:
                                    const EdgeInsets.fromLTRB(10, 2, 10, 2),
                                child: Text(
                                  item['name'],
                                  style: TextStyle(
                                    color: sortType == item['type']
                                        ? Colors.black
                                        : const Color(0xff999999),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  sortType == 2
                      ? Column(
                          children: homeDataPost
                              .map((item) => Container(
                                    margin: const EdgeInsets.only(top: 7),
                                    child: HomeOfficialCard1(
                                      itemData: item,
                                    ),
                                  ))
                              .toList(),
                        )
                      : Container(),
                  sortType != 2
                      ? Column(
                          children: homeDataPost
                              .map((item) => Container(
                                    margin: const EdgeInsets.only(top: 7),
                                    child: HomeOfficialCard2(
                                      itemData: item,
                                    ),
                                  ))
                              .toList(),
                        )
                      : Container(),
                ],
              ),
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
            return getData();
          },
        ),
      ),
    );
  }
}
