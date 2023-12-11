import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/comment_details.dart';
import 'package:imitate_miyoushe/common/comment_template.dart';
import 'package:imitate_miyoushe/common/refresh_load_more_indicator.dart';

class CommentDetails extends GetView<CommentDetailsController> {
  const CommentDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 40,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: const Text(
          '评论详情',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
      body: RefreshLoadMoreIndicator(
        onLoadMore: () async {
          return controller.getNextPage();
        },
        onRefresh: () async {
          controller.getData();
        },
        itemCount: 1,
        itemBuilder: (context, index) {
          return Obx(
            () => Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  child: controller.oldCommentData.isNotEmpty
                      ? CommentTemplate(
                          commentData: controller.oldCommentData['reply'],
                          LZID: controller.oldCommentData['reply']['user']
                              ['uid'],
                        )
                      : Container(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('全部评论'),
                      Container(
                        height: 1,
                        margin: const EdgeInsets.only(top: 15),
                        color: const Color(0xffebeff0),
                      ),
                      Column(
                        children: controller.commentList.isNotEmpty
                            ? List.from(controller.commentList).map(
                                (item) {
                                  return Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 15, 0, 5),
                                    child: CommentTemplate(
                                      commentData: item,
                                      LZID: controller.oldCommentData['reply']
                                          ['user']['uid'],
                                    ),
                                  );
                                },
                              ).toList()
                            : [],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
