import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/search.dart';
import 'package:imitate_miyoushe/common/keep_alive_wrapper.dart';
import 'search_topics.dart';
import 'search_post.dart';
import 'search_wiki.dart';
import 'search_user.dart';

class SearchTabBar extends GetView<SearchPageController> {
  const SearchTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: const Color(0xffffffff),
        automaticallyImplyLeading: false,
        elevation: 2,
        title: SizedBox(
          height: 30,
          child: TabBar(
            controller: controller.tabController,
            indicatorColor: const Color(0xffffe14c),
            indicatorWeight: 2,
            indicatorPadding: const EdgeInsets.only(bottom: 2),
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
            labelColor: Colors.black,
            unselectedLabelColor: const Color(0xff999999),
            tabs: controller.tabBarList.map((item) {
              return Tab(
                child: Text(
                  item['name'],
                ),
              );
            }).toList(),
          ),
        ),
      ),
      body: KeepAliveWrapper(
        child: TabBarView(
          controller: controller.tabController,
          children: const [
            SearchTopics(),
            SearchPost(),
            SearchWiki(),
            SearchUser(),
          ],
        ),
      ),
    );
  }
}
