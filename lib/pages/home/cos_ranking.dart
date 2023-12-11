import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/global.dart';
import 'package:imitate_miyoushe/http/request.dart';
import 'package:imitate_miyoushe/common/loading.dart';
import 'package:imitate_miyoushe/common/cache_image.dart';
import 'package:imitate_miyoushe/router/routes.dart';

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
      cosRanking = List.from(jsonResponse['data']['list']).toList();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rankData['title'],
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 115,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: cosRanking.map((img) {
                      return GestureDetector(
                        onTap: () {
                          MyRouter.push(
                            MyRouter.articleDetails,
                            {
                              'id': img['post']['post_id'],
                              'showType': widget.currentTab['show_type'],
                            },
                          );
                        },
                        child: Container(
                          height: 115,
                          width: 115,
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xffeff1f4),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 115,
                                  width: 115,
                                  child: CacheImage(
                                    imageUrl: img['cover']['url'],
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    height: 25,
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CacheImage(
                                              imageUrl: img['user']
                                                  ['avatar_url'],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          constraints: const BoxConstraints(
                                            maxWidth: 50,
                                          ),
                                          child: Text(
                                            img['user']['nickname'],
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          )
        : Container();
  }
}
