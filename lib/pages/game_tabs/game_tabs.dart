import 'package:flutter/material.dart';
import '../home/home.dart';
import '../home/home_other.dart';
import '../home/home_cos.dart';
import '../home/home_official.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/game_tabs.dart';

class GameTabs extends GetView<GameTabsController> {
  const GameTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: const Color(0xff1f2233),
          title: controller.loadingCompleted.value
              ? SizedBox(
                  height: 30,
                  child: TabBar(
                    controller: controller.tabController,
                    isScrollable: true,
                    indicatorColor: const Color(0xffffe14c),
                    indicatorWeight: 2,
                    indicatorPadding: const EdgeInsets.only(bottom: 5),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    unselectedLabelStyle: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.normal),
                    tabs: controller.categoryList.map((item) {
                      return Tab(
                        child: Text(
                          item['name'],
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                  ),
                )
              : null,
        ),
        body: controller.loadingCompleted.value
            ? TabBarView(
                controller: controller.tabController,
                children: controller.categoryList.map((item) {
                  if (item['id'] == '0') {
                    return const Home();
                  } else if (item['show_type'] == '4') {
                    return HomeCos(currentTab: item);
                  } else if (item['show_type'] == '3') {
                    return HomeOfficial(currentTab: item);
                  } else {
                    return HomeOther(currentTab: item);
                  }
                }).toList(),
              )
            : null,
      ),
    );
  }
}
