import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/utils/game_category_data.dart';
import 'package:imitate_miyoushe/common/game_category_dialog.dart';

class GlobalController extends GetxController {
  RxMap currentGameCategory = {}.obs;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  showGameCategoryDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return GameCategoryDialog();
      },
    );
  }

  selectGameCategory(data) {
    currentGameCategory["name"] = data["name"];
    currentGameCategory["id"] = data["id"];
    update();
  }

  @override
  void onInit() {
    super.onInit();
    var data = {
      "name": gameCategoryData[0]["name"],
      "id": gameCategoryData[0]["id"],
    };
    selectGameCategory(data);
  }
}
