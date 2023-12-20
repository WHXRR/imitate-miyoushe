import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/common/empty.dart';

class SearchEmpty extends GetView {
  const SearchEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Empty(
      tips: '暂无搜索历史哦，快来搜搜看吧~',
    );
  }
}
