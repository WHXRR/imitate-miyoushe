import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/topics.dart';
import 'topics_top.dart';
import 'topics_container.dart';
import 'package:imitate_miyoushe/common/refresh_load_more_indicator.dart';

class Topics extends GetView<TopicsController> {
  const Topics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.topicsInfo.isNotEmpty
          ? RefreshLoadMoreIndicator(
              onLoadMore: () async {
                if (controller.topicsData['is_last']) {
                  return LoadingMoreState.noData;
                }
                return controller.getTopicsData();
              },
              onRefresh: () async {
                controller.topicsList.value = [];
                controller.topicsData.value = {};
                controller.getTopicsData();
              },
              itemCount: 1,
              itemBuilder: (context, index) {
                return const Column(
                  children: [
                    SizedBox(
                      height: 220,
                      child: ClipRRect(
                        child: TopicsTop(),
                      ),
                    ),
                    TopicsContainer(),
                  ],
                );
              },
            )
          : Container(),
    );
  }
}
