import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../game_tabs/game_tabs.dart';
import 'package:imitate_miyoushe/controllers/global.dart';
import 'package:imitate_miyoushe/common/cache_image.dart';
import 'package:imitate_miyoushe/router/routes.dart';

class Index extends GetView<GlobalController> {
  const Index({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: const Color(0xff1f2233),
        leadingWidth: 33,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () {
              controller.showGameCategoryDialog(context);
            },
            child: const Icon(
              Icons.notes,
              size: 23,
            ),
          ),
        ),
        actions: [
          // const Padding(
          //   padding: EdgeInsets.only(right: 10),
          //   child: DownloadAPK(),
          // ),
          GestureDetector(
            onTap: () {
              MyRouter.push(MyRouter.search);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.search, size: 21),
            ),
          ),
          // const Padding(
          //   padding: EdgeInsets.only(right: 10),
          //   child: Icon(Icons.sms_outlined, size: 21),
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 10, 8),
            child: SizedBox(
              width: 24,
              height: 24,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: const CacheImage(
                  imageUrl:
                      'https://bbs-static.miyoushe.com/communityweb/upload/222b847170feb3f2babcc1bd4f0e30dd.png',
                ),
              ),
            ),
          )
        ],
        title: Obx(
          () => Text(
            controller.currentGameCategory["name"] ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xffcccccc),
            ),
          ),
        ),
      ),
      body: const GameTabs(),
    );
  }
}
