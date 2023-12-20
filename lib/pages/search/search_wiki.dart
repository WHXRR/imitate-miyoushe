import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/common/refresh_load_more_indicator.dart';
import 'package:imitate_miyoushe/controllers/search.dart';
import 'package:imitate_miyoushe/common/cache_image.dart';
import 'package:imitate_miyoushe/router/routes.dart';
import 'search_empty.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchWiki extends GetView<SearchPageController> {
  const SearchWiki({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => List.from(controller.tabBarData['wikisList']).isNotEmpty
          ? Container(
              color: const Color(0xfff2f4f5),
              child: RefreshLoadMoreIndicator(
                itemCount: controller.tabBarData['wikisList'].length,
                onLoadMore: () async {
                  return controller.getData(TabBarType.wikis);
                },
                onRefresh: () async {
                  controller.tabBarData['wikisData'] = {};
                  controller.tabBarData['wikisList'] = [];
                  controller.getData(TabBarType.wikis);
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      String path =
                          controller.tabBarData['wikisList'][index]['bbs_url'];
                      if (path.contains('article/')) {
                        var id = path.split('article/')[1];
                        MyRouter.push(
                          MyRouter.articleDetails,
                          {'id': id},
                        );
                      } else if (path.contains('https')) {
                        var url = Uri.parse(path);
                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch $path');
                        }
                      }
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${controller.tabBarData['wikisList'][index]['title']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            constraints:
                                const BoxConstraints(maxWidth: double.infinity),
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            child: CacheImage(
                              imageUrl: controller.tabBarData['wikisList']
                                  [index]['icon'],
                              fit: BoxFit.contain,
                            ),
                          ),
                          Row(
                            children: List.from(
                                    controller.tabBarData['wikisList'][index]
                                        ['channel_name'])
                                .map(
                              (e) {
                                return Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(6, 3, 6, 3),
                                  margin: const EdgeInsets.only(right: 5),
                                  decoration: const BoxDecoration(
                                    color: Color(0xff00c3ff),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                  ),
                                  child: Text(
                                    e,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : const SearchEmpty(),
    );
  }
}
