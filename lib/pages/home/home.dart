import 'package:flutter/material.dart';
import '../../http/request.dart';
import './home_swiper.dart';
import './home_article.dart';
import '../../common/keep_alive_wrapper.dart';
import '../../common/loading.dart';
import '../../common/refresh_load_more_indicator.dart';

class Home extends StatefulWidget {
  final Map currentGameCategory;
  const Home({
    Key? key,
    required this.currentGameCategory,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List homeDataPost = [];
  List bannerData = [];
  int _page = 1;

  Future<LoadingMoreState> getData() async {
    // 获取帖子数据
    var jsonResponse =
        await Request.requestGet('/apihub/wapi/webHome', params: {
      'gids': '${widget.currentGameCategory['id']}',
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
          'gids': '${widget.currentGameCategory['id']}',
          'post_ids': postIDs
        });
    var _list = List.from(jsonResponse['data']['recommended_posts'])
        .asMap()
        .entries
        .map((item) {
      item.value['stat2'] = articleData['data']['list'][item.key]['stat'];
      return item.value;
    }).toList();
    setState(() {
      homeDataPost.addAll(_list);
      bannerData = jsonResponse['data']['carousels'];
    });
    Loading.hideLoading();
    return LoadingMoreState.complete;
  }

  Future<LoadingMoreState> getNextPageData() {
    _page++;
    return getData();
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
            return Column(
              children: [
                HomeSwiper(bannerData: bannerData),
                HomeArticle(homeDataPost: homeDataPost),
              ],
            );
          },
          onLoadMore: () {
            return getNextPageData();
          },
          onRefresh: () async {
            setState(() {
              homeDataPost = [];
              bannerData = [];
            });
            await getData();
          },
        ),
      ),
    );
  }
}
