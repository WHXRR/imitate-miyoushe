import 'package:flutter/material.dart';
import 'package:imitate_miyoushe/utils/format_time.dart';
import 'package:imitate_miyoushe/router/routes.dart';
import 'package:imitate_miyoushe/common/triple_like.dart';
import 'package:imitate_miyoushe/common/image_preview_screen.dart';
import 'package:imitate_miyoushe/common/cache_image.dart';

class UserPost extends StatelessWidget {
  final Map itemData;
  final List<String> imgLists;
  const UserPost({Key? key, required this.itemData, required this.imgLists})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int initialIndex = 0;
    void previewImg(img) {
      initialIndex = imgLists.indexWhere((element) => element == img);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePreviewScreen(
            imageUrls: imgLists,
            initialIndex: initialIndex,
          ),
        ),
      );
    }

    var timeList = formatTime(itemData['post']['created_at']).split('-');
    var day = timeList[2];
    var month = timeList[1];
    var year = timeList[0];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          MyRouter.push(
            MyRouter.articleDetails,
            {
              'id': itemData['post']['post_id'],
              'showType': itemData['post']['view_type'],
            },
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                      child: Image.asset(
                        'images/shizhong.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            day,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xffcccccc),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            '$month月/$year年',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xffcccccc),
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            width: itemData['forum'] == null ? 0 : 5,
                            height: 5,
                            margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffcccccc),
                            ),
                          ),
                          Text(
                            itemData['forum'] == null
                                ? ''
                                : itemData['forum']['name'],
                            strutStyle: const StrutStyle(
                              forceStrutHeight: true,
                              leading: 0.0,
                            ),
                            style: const TextStyle(
                              color: Color(0xffcccccc),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    itemData['post']['subject'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                itemData['post']['content'].toString().isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          itemData['post']['content'],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xff999999),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            List.from(itemData['image_list']).isNotEmpty
                ? Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 115,
                    child: GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 7,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.from(itemData['image_list'])
                            .take(3)
                            .map((img) {
                          return GestureDetector(
                            onTap: () {
                              previewImg(img['url']);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: CacheImage(
                                imageUrl: img['url'],
                                memCacheWidth: 500,
                              ),
                            ),
                          );
                        }).toList()),
                  )
                : Container(),
            Wrap(
              children: List.from(itemData['topics']).map((v) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                  margin: const EdgeInsets.fromLTRB(0, 7, 10, 0),
                  decoration: BoxDecoration(
                    color: const Color(0xffedf6fc),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    v['name'],
                    style:
                        const TextStyle(color: Color(0xff00b2ff), fontSize: 10),
                  ),
                );
              }).toList(),
            ),
            Container(
              height: 1,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              color: const Color(0xfff0f4f5),
            ),
            TripleLike(
              numberData: itemData['stat2'] ?? itemData['stat'],
            ),
          ],
        ),
      ),
    );
  }
}
