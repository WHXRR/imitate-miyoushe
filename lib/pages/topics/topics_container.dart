import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/topics.dart';
import 'package:imitate_miyoushe/pages/article/home_article.dart';

class TopicsContainer extends GetView<TopicsController> {
  const TopicsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xfff0f4f5),
                ),
              ),
            ),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.listType.value = 0;
                        controller.topicsList.value = [];
                        controller.topicsData.value = {};
                        controller.getTopicsData();
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 7),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 3,
                              color: controller.listType.value == 0
                                  ? const Color(0xffffe14c)
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        child: Text(
                          "最新",
                          style: TextStyle(
                            color: controller.listType.value == 0
                                ? Colors.black
                                : const Color(0xff999999),
                            fontWeight: controller.listType.value == 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.listType.value = 2;
                        controller.topicsList.value = [];
                        controller.topicsData.value = {};
                        controller.getTopicsData();
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 7),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 3,
                              color: controller.listType.value == 2
                                  ? const Color(0xffffe14c)
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        child: Text(
                          "热门",
                          style: TextStyle(
                            color: controller.listType.value == 2
                                ? Colors.black
                                : const Color(0xff999999),
                            fontWeight: controller.listType.value == 2
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                controller.topicsInfo.isNotEmpty
                    ? DropdownButton(
                        value: controller.currentGameID.value,
                        underline: Container(height: 0),
                        items:
                            List.from(controller.topicsInfo['game_info_list'])
                                .map(
                                  (item) => DropdownMenuItem(
                                    value: item['id'] as int,
                                    child: Text(
                                      item['name'],
                                      style: const TextStyle(
                                        color: Color(0xff999999),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (v) {
                          controller.currentGameID.value = v!;
                          controller.topicsList.value = [];
                          controller.topicsData.value = {};
                          controller.getTopicsData();
                        },
                      )
                    : Container()
              ],
            ),
          ),
          controller.topicsData.isNotEmpty
              ? ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: controller.topicsList
                      .map(
                        (item) => HomeArticle(
                          itemData: item,
                        ),
                      )
                      .toList(),
                )
              : Container(),
        ],
      ),
    );
  }
}
