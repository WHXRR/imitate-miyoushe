import 'package:flutter/material.dart';
import 'package:imitate_miyoushe/common/cache_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:imitate_miyoushe/utils/formatTime.dart';

class CommentTemplate extends StatelessWidget {
  final Map commentData;
  final String LZID;
  final Widget? itemBuilder;
  const CommentTemplate({
    Key? key,
    required this.commentData,
    required this.LZID,
    this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 35,
          height: 35,
          margin: const EdgeInsets.only(right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CacheImage(
              imageUrl: commentData['user']['avatar_url'],
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${commentData['user']['nickname']}',
                    style:
                        const TextStyle(color: Color(0xff404040), fontSize: 15),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 3),
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                    decoration: BoxDecoration(
                      color: const Color(0xffffbf00),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      'lv ${commentData['user']['level_exp']['level']}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 7,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                '来自${commentData['user']['ip_region']}',
                style: const TextStyle(
                  fontSize: 9,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              commentData['r_user'] != null &&
                      commentData['r_user']['uid'] != LZID
                  ? Row(
                      children: [
                        const Text(
                          '回复 ',
                          style: TextStyle(
                            color: Color(0xffcccccc),
                          ),
                        ),
                        Text(
                          '${commentData['r_user']['nickname']}',
                          style: const TextStyle(
                            color: Color(0xff00c3ff),
                          ),
                        ),
                        const Text(' :')
                      ],
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Html(
                  data: commentData['reply']['content'],
                  style: {
                    'body': Style(
                      backgroundColor: Colors.white,
                      padding: HtmlPaddings.all(0),
                      margin: Margins.all(0),
                    ),
                    'img': Style(
                      padding: HtmlPaddings.only(
                        top: 5,
                        bottom: 5,
                      ),
                    )
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatTimeHMS(commentData['reply']['created_at']),
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.thumb_up_outlined,
                          color: Color(0xff999999),
                          size: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          commentData['stat']['like_num'].toString(),
                          style: const TextStyle(
                            color: Color(0xff999999),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Icon(
                          Icons.thumb_down_outlined,
                          color: Color(0xff999999),
                          size: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          commentData['stat']['dislike_num'].toString(),
                          style: const TextStyle(
                            color: Color(0xff999999),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              itemBuilder != null
                  ? const SizedBox(
                      height: 10,
                    )
                  : Container(),
              itemBuilder ?? Container(),
            ],
          ),
        ),
      ],
    );
  }
}
