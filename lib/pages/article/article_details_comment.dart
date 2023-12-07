import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/article_details.dart';
import 'package:imitate_miyoushe/utils/formatTime.dart';

class ArticleDetailsComment extends GetView<ArticleDetailsController> {
  const ArticleDetailsComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.onlyMaster.value = false;
                      controller.getComments();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: controller.onlyMaster.value
                                ? Colors.transparent
                                : const Color(0xffffe14c),
                          ),
                        ),
                      ),
                      child: Text(
                        '全部评论',
                        style: TextStyle(
                          color: controller.onlyMaster.value
                              ? const Color(0xff999999)
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      controller.onlyMaster.value = true;
                      controller.orderType.value = 0;
                      controller.getComments();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: controller.onlyMaster.value
                                ? const Color(0xffffe14c)
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      child: Text(
                        '只看楼主',
                        style: TextStyle(
                          color: controller.onlyMaster.value
                              ? Colors.black
                              : const Color(0xff999999),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              controller.onlyMaster.value
                  ? const SizedBox()
                  : Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.orderType.value = 0;
                            controller.getComments();
                          },
                          child: Text(
                            '热门',
                            style: TextStyle(
                              color: controller.orderType.value == 0
                                  ? Colors.black
                                  : const Color(0xffcccccc),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            controller.orderType.value = 1;
                            controller.getComments();
                          },
                          child: Text(
                            '最早',
                            style: TextStyle(
                              color: controller.orderType.value == 1
                                  ? Colors.black
                                  : const Color(0xffcccccc),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            controller.orderType.value = 2;
                            controller.getComments();
                          },
                          child: Text(
                            '最新',
                            style: TextStyle(
                              color: controller.orderType.value == 2
                                  ? Colors.black
                                  : const Color(0xffcccccc),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          controller.commentList.isEmpty
              ? const Center(
                  heightFactor: 4,
                  child: Text(
                    '暂时还没有回复噢',
                    style: TextStyle(
                      color: Color(0xffcccccc),
                    ),
                  ),
                )
              : Column(
                  children: controller.commentList.map((item) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                      padding: const EdgeInsets.only(bottom: 10),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 0.3,
                            color: Color(0xffcccccc),
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            margin: const EdgeInsets.only(right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(item['user']['avatar_url'],
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${item['user']['nickname']}',
                                      style: const TextStyle(
                                          color: Color(0xff404040),
                                          fontSize: 15),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 3),
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 2, 5, 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffffbf00),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: Text(
                                        'lv ${item['user']['level_exp']['level']}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 7,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  '来自${item['user']['ip_region']}',
                                  style: const TextStyle(
                                    fontSize: 9,
                                    color: Colors.grey,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    item['reply']['content'],
                                    style: const TextStyle(
                                      color: Color(0xff404040),
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        formatTimeHMS(
                                            item['reply']['created_at']),
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.thumb_up_outlined,
                                            color: Color(0xff999999),
                                            size: 15,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            item['stat']['like_num'].toString(),
                                            style: const TextStyle(
                                              color: Color(0xff999999),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          const Icon(
                                            Icons.thumb_down_outlined,
                                            color: Color(0xff999999),
                                            size: 15,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            item['stat']['dislike_num']
                                                .toString(),
                                            style: const TextStyle(
                                              color: Color(0xff999999),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}
