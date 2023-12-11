import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/article_details.dart';
import 'package:imitate_miyoushe/router/routes.dart';
import 'package:imitate_miyoushe/common/comment_template.dart';

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
                      child: CommentTemplate(
                        commentData: item,
                        LZID: item['user']['uid'],
                        itemBuilder: List.from(item['sub_replies']).isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  MyRouter.push(
                                    MyRouter.commentDetails,
                                    {
                                      'floor_id': item['reply']['floor_id'],
                                      'reply_id': item['reply']['reply_id']
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 10, 5),
                                        color: const Color(0xfff7f9fa),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children:
                                                  List.from(item['sub_replies'])
                                                      .map((ele) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '${ele['user']['nickname']}',
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xff00c3ff),
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        ele['r_user']['uid'] !=
                                                                item['user']
                                                                    ['uid']
                                                            ? const Text(
                                                                ' 回复 ',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xffcccccc),
                                                                  fontSize: 13,
                                                                ),
                                                              )
                                                            : const Text(''),
                                                        ele['r_user']['uid'] !=
                                                                item['user']
                                                                    ['uid']
                                                            ? Text(
                                                                '${ele['r_user']['nickname']}',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xff00c3ff),
                                                                  fontSize: 13,
                                                                ),
                                                              )
                                                            : const Text(''),
                                                        const Text(
                                                          ' :',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      '${ele['reply']['content']}',
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    )
                                                  ],
                                                );
                                              }).toList(),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                item['sub_reply_count'] >= 3
                                                    ? Text(
                                                        '查看全部${item['sub_reply_count']}条评论 >',
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            color: Color(
                                                                0xff00c3ff)),
                                                      )
                                                    : Container(),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}
