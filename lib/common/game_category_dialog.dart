import 'package:flutter/material.dart';
import '../utils/game_category_data.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/global.dart';
import 'package:imitate_miyoushe/controllers/game_tabs.dart';

class GameCategoryDialog extends Dialog {
  GameCategoryDialog({Key? key}) : super(key: key);

  GlobalController globalController = Get.find();
  GameTabsController gameTabsController = Get.find();

  @override
  Widget build(BuildContext context) {
    List<Widget> _initGameCategoryList() {
      return gameCategoryData.map((e) {
        return InkWell(
          onTap: () {
            globalController.selectGameCategory(e);
            gameTabsController.retrieveGameData();
            Navigator.pop(context);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(e["src"]),
              ),
              const SizedBox(height: 2),
              Text(
                '${e["name"]}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 10),
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
                height: 190,
                child: GridView.count(
                  crossAxisCount: 5,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                  children: _initGameCategoryList(),
                ),
              ),
            )
          ],
        ));
  }
}
