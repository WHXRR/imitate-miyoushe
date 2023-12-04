import 'package:flutter/material.dart';
import '../../utils/formatTime.dart';

class HomeArticle extends StatefulWidget {
  final List homeDataPost;
  const HomeArticle({Key? key, required this.homeDataPost}) : super(key: key);

  @override
  _HomeArticleState createState() => _HomeArticleState();
}

class _HomeArticleState extends State<HomeArticle> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.homeDataPost.isNotEmpty
          ? widget.homeDataPost.map((item) {
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                          width: 35,
                          height: 35,
                          margin: const EdgeInsets.only(right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(item['user']['avatar_url'],
                                fit: BoxFit.cover),
                          )),
                      Expanded(
                          flex: 1,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${item['user']['nickname']}',
                                      style: const TextStyle(
                                          color: Color(0xff404040),
                                          fontSize: 12),
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
                                        'lv ${item['user']['level_exp']['level']}',
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
                                      formatTime(item['post']['created_at']),
                                      textAlign: TextAlign.center,
                                      strutStyle: const StrutStyle(
                                        forceStrutHeight: true,
                                        leading: 0.0,
                                      ),
                                      style: const TextStyle(
                                          color: Color(0xffcccccc),
                                          fontSize: 12),
                                    ),
                                    Container(
                                      width: item['forum'] == null ? 0 : 5,
                                      height: 5,
                                      margin:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffcccccc),
                                      ),
                                    ),
                                    Text(
                                      item['forum'] == null
                                          ? ''
                                          : item['forum']['name'],
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
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      item['post']['subject'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      item['post']['content'],
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xff999999),
                      ),
                    ),
                    List.from(item['image_list']).isNotEmpty
                        ? Container(
                            margin: const EdgeInsets.only(top: 5),
                            height: 115,
                            child: GridView.count(
                                crossAxisCount: 3,
                                crossAxisSpacing: 7,
                                physics: const NeverScrollableScrollPhysics(),
                                children: List.from(item['image_list'])
                                    .take(3)
                                    .map((img) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      img['url'],
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }).toList()),
                          )
                        : Container(),
                    Wrap(
                      children: List.from(item['topics']).map((v) {
                        return Container(
                          padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                          margin: const EdgeInsets.fromLTRB(0, 7, 10, 0),
                          decoration: BoxDecoration(
                            color: const Color(0xffedf6fc),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            v['name'],
                            style: const TextStyle(
                                color: Color(0xff00b2ff), fontSize: 10),
                          ),
                        );
                      }).toList(),
                    ),
                    Container(
                      height: 1,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      color: const Color(0xfff0f4f5),
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: Color(0xff999999),
                                    size: 17,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${item['stat2'] == null ? item['stat']['view_num'] : item['stat2']['view_num']}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff999999),
                                    ),
                                  )
                                ])),
                        Expanded(
                            flex: 1,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.comment_outlined,
                                    color: Color(0xff999999),
                                    size: 17,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${item['stat2'] == null ? item['stat']['reply_num'] : item['stat2']['reply_num']}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff999999),
                                    ),
                                  )
                                ])),
                        Expanded(
                            flex: 1,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.thumb_up_outlined,
                                    color: Color(0xff999999),
                                    size: 17,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${item['stat2'] == null ? item['stat']['like_num'] : item['stat2']['like_num']}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff999999),
                                    ),
                                  )
                                ])),
                      ],
                    )
                  ],
                ),
              );
            }).toList()
          : [],
    );
  }
}
