import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/common/refresh_load_more_indicator.dart';
import 'package:imitate_miyoushe/controllers/search.dart';
import 'search_empty.dart';
import 'package:imitate_miyoushe/router/routes.dart';
import 'package:imitate_miyoushe/utils/text_highlighting.dart';

class SearchUser extends GetView<SearchPageController> {
  const SearchUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => List.from(controller.tabBarData['usersList']).isNotEmpty
          ? Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: RefreshLoadMoreIndicator(
                itemCount: controller.tabBarData['usersList'].length,
                onLoadMore: () async {
                  return controller.getData(TabBarType.users);
                },
                onRefresh: () async {
                  controller.tabBarData['usersData'] = {};
                  controller.tabBarData['usersList'] = [];
                  controller.getData(TabBarType.users);
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      MyRouter.push(MyRouter.user, {
                        "id": controller.tabBarData['usersList'][index]['uid'],
                      });
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Flex(
                        direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: Image.network(
                                      controller.tabBarData['usersList'][index]
                                          ['avatar_url'])
                                  .image,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(top: 5, bottom: 15),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: Color(0xfff0f4f5),
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  formatText(
                                    controller.tabBarData['usersList'][index]
                                        ['nickname'],
                                    controller.keyword.value,
                                  ),
                                  Text(
                                    '${controller.tabBarData['usersList'][index]['introduce']}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xffcccccc),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
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
