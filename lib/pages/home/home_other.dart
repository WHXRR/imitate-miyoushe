import 'package:flutter/material.dart';
import './home_article.dart';
import '../../common/keep_alive_wrapper.dart';
import '../../http/request.dart';
import '../../common/loading.dart';
import '../../common/refresh_load_more_indicator.dart';

class HomeOther extends StatefulWidget {
  final Map currentGameCategory;
  final Map currentTab;
  const HomeOther({
    Key? key,
    required this.currentGameCategory,
    required this.currentTab,
  }) : super(key: key);

  @override
  _HomeOtherState createState() => _HomeOtherState();
}

class _HomeOtherState extends State<HomeOther> {
  Map<String, dynamic> postDataMap = {};
  List homeDataPost = [];

  Future<LoadingMoreState> getData() async {
    // 获取帖子数据
    var jsonResponse =
        await Request.requestGet('/post/wapi/getForumPostList', params: {
      'gids': '${widget.currentGameCategory['id']}',
      'forum_id': '${widget.currentTab['id']}',
      'page_size': '10',
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
        'gids': '${widget.currentGameCategory['id']}',
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
      Loading.showLoading(context);
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
            return HomeArticle(homeDataPost: homeDataPost);
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
