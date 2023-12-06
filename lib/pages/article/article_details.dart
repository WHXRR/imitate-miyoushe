import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/article_details.dart';
import 'package:imitate_miyoushe/common/refresh_load_more_indicator.dart';
import 'article_details_user.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:imitate_miyoushe/utils/formatTime.dart';
import 'package:imitate_miyoushe/common/article_details_triple_like.dart';

class ArticleDetails extends GetView<ArticleDetailsController> {
  const ArticleDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.loadingCompleted.value
        ? Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              toolbarHeight: 40,
              backgroundColor: Colors.white,
              centerTitle: true,
              elevation: 1,
              title: Text(
                '${controller.articleData['forum']['name']}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              color: Colors.white,
              child: RefreshLoadMoreIndicator(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ArticleDetailsUser(),
                      Text(
                        '${controller.articleData['post']['subject']}',
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '——文章发表：${formatTime(controller.articleData['post']['created_at'])}——',
                            textAlign: TextAlign.center,
                            strutStyle: const StrutStyle(
                              forceStrutHeight: true,
                              leading: 0.0,
                            ),
                            style: const TextStyle(
                                color: Color(0xffcccccc), fontSize: 12),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Html(
                        data: '${controller.articleData['post']['content']}',
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        decoration: const BoxDecoration(
                            border: Border(
                          top: BorderSide(
                            color: Color(0xfff0f4f5),
                          ),
                          bottom: BorderSide(
                            color: Color(0xfff0f4f5),
                          ),
                        )),
                        child: ArticleDetailsTripleLike(
                            numberData: controller.articleData['stat']),
                      ),
                    ],
                  );
                },
                onLoadMore: () async {
                  return LoadingMoreState.noData;
                },
                onRefresh: () async {
                  controller.getArticleData();
                },
              ),
            ),
          )
        : Container());
  }
}
