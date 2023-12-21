import 'package:flutter/material.dart';
import 'package:imitate_miyoushe/utils/format_time.dart';
import 'package:imitate_miyoushe/router/routes.dart';
import 'package:imitate_miyoushe/common/triple_like.dart';
import 'package:imitate_miyoushe/common/image_preview_screen.dart';
import 'package:imitate_miyoushe/common/cache_image.dart';
import 'package:imitate_miyoushe/utils/text_highlighting.dart';

class HomeArticle extends StatefulWidget {
  final Map itemData;
  final bool? isSearch;
  final String? searchKeyword;
  const HomeArticle({
    Key? key,
    required this.itemData,
    this.isSearch = false,
    this.searchKeyword,
  }) : super(key: key);

  @override
  _HomeArticleState createState() => _HomeArticleState();
}

class _HomeArticleState extends State<HomeArticle> {
  List<String> imgLists = [];
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

  @override
  void initState() {
    super.initState();
    imgLists = List.from(widget.itemData['image_list'])
        .map((e) => e['url'].toString())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          MyRouter.push(
            MyRouter.articleDetails,
            {
              'id': widget.itemData['post']['post_id'],
              'showType': widget.itemData['post']['view_type'],
            },
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                    width: 35,
                    height: 35,
                    margin: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          Image.network(widget.itemData['user']['avatar_url'])
                              .image,
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${widget.itemData['user']['nickname']}',
                                  style: const TextStyle(
                                      color: Color(0xff404040), fontSize: 12),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 3),
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 2, 5, 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffbf00),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Text(
                                    'lv ${widget.itemData['user']['level_exp']['level']}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 7,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  formatTime(
                                      widget.itemData['post']['created_at']),
                                  textAlign: TextAlign.center,
                                  strutStyle: const StrutStyle(
                                    forceStrutHeight: true,
                                    leading: 0.0,
                                  ),
                                  style: const TextStyle(
                                    color: Color(0xffcccccc),
                                    fontSize: 12,
                                  ),
                                ),
                                Container(
                                  width:
                                      widget.itemData['forum'] == null ? 0 : 5,
                                  height: 5,
                                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffcccccc),
                                  ),
                                ),
                                Text(
                                  widget.itemData['forum'] == null
                                      ? ''
                                      : widget.itemData['forum']['name'],
                                  strutStyle: const StrutStyle(
                                    forceStrutHeight: true,
                                    leading: 0.0,
                                  ),
                                  style: const TextStyle(
                                    color: Color(0xffcccccc),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )
                          ]))
                ]),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: widget.isSearch!
                      ? formatText(
                          widget.itemData['post']['subject'],
                          widget.searchKeyword,
                        )
                      : Text(
                          widget.itemData['post']['subject'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                widget.itemData['post']['content'].toString().isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          widget.itemData['post']['content'],
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
            List.from(widget.itemData['image_list']).isNotEmpty
                ? Container(
                    margin: const EdgeInsets.only(top: 5),
                    // height: 130,
                    child: GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 7,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.from(widget.itemData['image_list'])
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
              children: List.from(widget.itemData['topics']).map((v) {
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
              numberData: widget.itemData['stat2'] ?? widget.itemData['stat'],
            ),
          ],
        ),
      ),
    );
  }
}
