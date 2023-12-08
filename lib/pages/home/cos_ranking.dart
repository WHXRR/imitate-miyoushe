import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/global.dart';
import 'package:imitate_miyoushe/http/request.dart';
import 'package:imitate_miyoushe/common/loading.dart';
import 'package:imitate_miyoushe/common/cache_image.dart';

class CosRanking extends StatefulWidget {
  final Map currentTab;
  const CosRanking({Key? key, required this.currentTab}) : super(key: key);

  @override
  _CosRankingState createState() => _CosRankingState();
}

class _CosRankingState extends State<CosRanking> {
  GlobalController globalController = Get.find();
  // 获取榜单
  Map rankData = {};
  List cosRanking = [];
  getCosRanking() async {
    var jsonResponse =
        await Request.requestGet('/post/wapi/getImagePostTopN', params: {
      'gids': '${globalController.currentGameCategory['id']}',
      'forum_id': '${widget.currentTab['id']}',
    });
    setState(() {
      rankData = jsonResponse['data'];
      cosRanking = List.from(jsonResponse['data']['list']).take(3).toList();
    });
    Loading.hideLoading();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Loading.showLoading();
      getCosRanking();
    });
  }

  @override
  Widget build(BuildContext context) {
    return rankData.isNotEmpty
        ? Container(
            color: Colors.white,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                rankData['title'],
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                height: 115,
                child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 7,
                    physics: const NeverScrollableScrollPhysics(),
                    children: cosRanking.map((img) {
                      return GestureDetector(
                        onTap: () {
                          // previewImg(img['url']);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xffeff1f4),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Hero(
                              tag: img['cover']['url'],
                              child: CacheImage(
                                imageUrl: img['cover']['url'],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList()),
              )
            ]),
          )
        : Container();
  }
}
