import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/common/refresh_load_more_indicator.dart';
import 'package:imitate_miyoushe/controllers/search.dart';
import 'package:imitate_miyoushe/common/cache_image.dart';
import 'package:imitate_miyoushe/router/routes.dart';
import 'search_empty.dart';
import 'package:imitate_miyoushe/utils/text_highlighting.dart';

class SearchTopics extends GetView<SearchPageController> {
  const SearchTopics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => List.from(controller.tabBarData['topicsList']).isNotEmpty
          ? Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: RefreshLoadMoreIndicator(
                itemCount: controller.tabBarData['topicsList'].length,
                onLoadMore: () async {
                  return controller.getData(TabBarType.topics);
                },
                onRefresh: () async {
                  controller.tabBarData['topicsData'] = {};
                  controller.tabBarData['topicsList'] = [];
                  controller.getData(TabBarType.topics);
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      MyRouter.push(MyRouter.topics, {
                        "id": controller.tabBarData['topicsList'][index]['id'],
                      });
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: Image.network(controller
                                      .tabBarData['topicsList'][index]['cover'])
                                  .image,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  formatText(
                                    controller.tabBarData['topicsList'][index]
                                        ['name'],
                                    controller.keyword.value,
                                  ),
                                  Text(
                                    '${controller.tabBarData['topicsList'][index]['desc']}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xffcccccc),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : const SearchEmpty(),
    );
  }
}
