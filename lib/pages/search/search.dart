import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'search_ipt.dart';
import 'search_empty.dart';
import 'search_tabbar.dart';
import 'package:imitate_miyoushe/controllers/search.dart';

class Search extends GetView<SearchPageController> {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xffffffff),
        title: const SearchIpt(),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Obx(
          () => Column(
            children: [
              controller.keyword.isEmpty
                  ? const SearchEmpty()
                  : const Expanded(
                      flex: 1,
                      child: SearchTabBar(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
