import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripleLike extends GetView {
  final Map numberData;
  const TripleLike({
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
                Icons.remove_red_eye_outlined,
                color: Color(0xff999999),
                size: 17,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '${numberData['view_num']}',
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
      ],
    );
  }
}
