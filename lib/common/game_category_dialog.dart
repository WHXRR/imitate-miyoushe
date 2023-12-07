import 'package:flutter/material.dart';
import '../utils/game_category_data.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/global.dart';
import 'package:imitate_miyoushe/controllers/game_tabs.dart';
import 'package:imitate_miyoushe/controllers/home.dart';

class GameCategoryDialog extends Dialog {
  GameCategoryDialog({Key? key}) : super(key: key);

  final GlobalController globalController = Get.find();
  final GameTabsController gameTabsController = Get.find();
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    List<Widget> _initGameCategoryList() {
      return gameCategoryData.map((e) {
        return InkWell(
          onTap: () {
            globalController.selectGameCategory(e);
            gameTabsController.retrieveGameData();
            homeController.bannerData.value = [];
            homeController.homeDataPost.value = [];
            homeController.getData();
            Navigator.pop(context);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 52,
                height: 52,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(e["src"]),
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                width: 50,
                child: Text(
                  '${e["name"]}',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 10),
                ),
              )
            ],
          ),
        );
      }).toList();
    }

    return Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                padding: const EdgeInsets.all(15),
                child: Wrap(
                  spacing: 17,
                  runSpacing: 15,
                  children: _initGameCategoryList(),
                ),
              ),
            )
          ],
        ));
  }
}
