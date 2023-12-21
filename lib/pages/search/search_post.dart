import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/common/refresh_load_more_indicator.dart';
import 'package:imitate_miyoushe/controllers/search.dart';
import 'package:imitate_miyoushe/pages/article/home_article.dart';
import 'search_empty.dart';

class SearchPost extends GetView<SearchPageController> {
  const SearchPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => List.from(controller.tabBarData['postsList']).isNotEmpty
          ? Container(
              color: const Color(0xfff2f4f5),
              child: RefreshLoadMoreIndicator(
                itemCount: controller.tabBarData['postsList'].length,
                onLoadMore: () async {
                  return controller.getData(TabBarType.posts);
                },
                onRefresh: () async {
                  controller.tabBarData['postsData'] = {};
                  controller.tabBarData['postsList'] = [];
                  controller.getData(TabBarType.posts);
                },
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: HomeArticle(
                      itemData: controller.tabBarData['postsList'][index],
                      isSearch: true,
                      searchKeyword: controller.keyword.value,
                    ),
                  );
                },
              ),
            )
          : const SearchEmpty(),
    );
  }
}
