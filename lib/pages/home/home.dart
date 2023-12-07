import 'package:flutter/material.dart';
import './home_swiper.dart';
import '../article/home_article.dart';
import 'package:imitate_miyoushe/common/keep_alive_wrapper.dart';
import 'package:imitate_miyoushe/common/refresh_load_more_indicator.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/home.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfff2f4f5),
      child: KeepAliveWrapper(
        child: RefreshLoadMoreIndicator(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                const HomeSwiper(),
                Obx(
                  () => Column(
                    children: controller.homeDataPost.isNotEmpty
                        ? controller.homeDataPost.map((item) {
                            return HomeArticle(
                              itemData: item,
                            );
                          }).toList()
                        : [],
                  ),
                ),
              ],
            );
          },
          onLoadMore: () {
            return controller.getNextPageData();
          },
          onRefresh: () async {
            controller.homeDataPost.value = [];
            controller.bannerData.value = [];
            await controller.getData();
          },
        ),
      ),
    );
  }
}
