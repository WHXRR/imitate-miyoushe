import 'package:flutter/material.dart';
import '../http/request.dart';
import '../pages/home/home.dart';
import '../pages/home/home_other.dart';

class GameTabs extends StatefulWidget {
  final Map currentGameCategory;
  const GameTabs({Key? key, required this.currentGameCategory})
      : super(key: key);

  @override
  GameTabsState createState() => GameTabsState();
}

class GameTabsState extends State<GameTabs> with TickerProviderStateMixin {
  late TabController _tabController;
  late List categoryList;
  bool _loadingCompleted = false;

  // 获取游戏分类
  void getGameTabs() async {
    var jsonResponse = await Request.requestGet(
        '/forum/wapi/getForumsByGameForPHP',
        params: {'gids': '${widget.currentGameCategory['id']}'});
    List list = jsonResponse['data']['forumlists'];
    list.insert(0, {
      'id': '0',
      'name': '推荐',
    });
    setState(() {
      categoryList = list;
      _tabController = TabController(length: categoryList.length, vsync: this);
      _loadingCompleted = true;
    });
    _tabController.addListener(() {
      if (_tabController.animation?.value == _tabController.index) {
        print(12112);
      }
    });
  }

  void retrieveGameData() {
    setState(() {
      _tabController.dispose();
      _loadingCompleted = false;
    });
    getGameTabs();
  }

  @override
  void initState() {
    super.initState();
    getGameTabs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: const Color(0xff1f2233),
        title: _loadingCompleted
            ? SizedBox(
                height: 30,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: const Color(0xffffe14c),
                  indicatorWeight: 2,
                  indicatorPadding: const EdgeInsets.only(bottom: 5),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  unselectedLabelStyle: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.normal),
                  tabs: categoryList.map((item) {
                    return Tab(
                      child: Text(item['name'],
                          style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                ),
              )
            : null,
      ),
      body: _loadingCompleted
          ? TabBarView(
              controller: _tabController,
              children: categoryList.map((item) {
                if (item['id'] == '0') {
                  return Home(
                    currentGameCategory: widget.currentGameCategory,
                  );
                } else {
                  return HomeOther(
                    currentGameCategory: widget.currentGameCategory,
                    currentTab: item,
                  );
                }
              }).toList(),
            )
          : null,
    );
  }
}
