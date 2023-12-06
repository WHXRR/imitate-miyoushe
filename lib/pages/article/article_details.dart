import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/article_details.dart';
import 'package:imitate_miyoushe/common/refresh_load_more_indicator.dart';
import 'article_details_user.dart';

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
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: RefreshLoadMoreIndicator(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ArticleDetailsUser(),
                    ],
                  );
                },
                onLoadMore: () async {
                  return LoadingMoreState.noData;
                },
                onRefresh: () async {
                  print(1);
                },
              ),
            ),
          )
        : Container());
  }
}
