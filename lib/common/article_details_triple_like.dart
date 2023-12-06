import 'package:flutter/material.dart';

class ArticleDetailsTripleLike extends StatelessWidget {
  final Map numberData;
  const ArticleDetailsTripleLike({
    Key? key,
    required this.numberData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(
                Icons.comment_outlined,
                color: Color(0xff999999),
                size: 17,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '${numberData['reply_num']}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff999999),
                ),
              )
            ])),
        Expanded(
            flex: 1,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(
                Icons.thumb_up_outlined,
                color: Color(0xff999999),
                size: 17,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '${numberData['like_num']}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff999999),
                ),
              )
            ])),
        Expanded(
            flex: 1,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(
                Icons.favorite_outline,
                color: Color(0xff999999),
                size: 17,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '${numberData['bookmark_num']}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff999999),
                ),
              )
            ])),
      ],
    );
  }
}
