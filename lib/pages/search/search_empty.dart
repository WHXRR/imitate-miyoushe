import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchEmpty extends GetView {
  const SearchEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 50),
          width: 200,
          child: Image.asset(
            'images/empty.png',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          '暂无搜索历史哦，快来搜搜看吧~',
          style: TextStyle(
            fontSize: 15,
            color: Color(0xffcccccc),
          ),
        )
      ],
    );
  }
}
