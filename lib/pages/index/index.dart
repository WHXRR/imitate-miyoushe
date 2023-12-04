import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/game_category_dialog.dart';
import '../../utils/game_category_data.dart';
import '../../common/game_tabs.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> with TickerProviderStateMixin {
  final GlobalKey<GameTabsState> _globalKey = GlobalKey();
  // 当前选中的游戏分类
  final RxMap currentGameCategory = {}.obs;
  final ScrollController _scrollController = ScrollController();

  void selectGameCategory(data) {
    currentGameCategory["name"] = data["name"];
    currentGameCategory["id"] = data["id"];
    _globalKey.currentState?.retrieveGameData();
  }

  void showGameCategoryDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return GameCategoryDialog(
              currentGameCategory: currentGameCategory, cb: selectGameCategory);
        });
  }

  @override
  void initState() {
    super.initState();
    currentGameCategory["name"] = gameCategoryData[0]["name"];
    currentGameCategory["id"] = gameCategoryData[0]["id"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: const Color(0xff1f2233),
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: showGameCategoryDialog,
              child: const Icon(
                Icons.notes,
                size: 23,
              ),
            ),
          ),
          leadingWidth: 33,
          actions: [
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.search, size: 21),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.sms_outlined, size: 21),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 10, 8),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                        'https://bbs-static.miyoushe.com/communityweb/upload/222b847170feb3f2babcc1bd4f0e30dd.png')))
          ],
          title: Obx(() => Text(currentGameCategory["name"],
              style: const TextStyle(fontSize: 16, color: Color(0xffcccccc)))),
        ),
        body: GameTabs(
          key: _globalKey,
          currentGameCategory: currentGameCategory,
        ));
  }
}
