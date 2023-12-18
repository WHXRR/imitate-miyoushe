import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/search.dart';

class SearchIpt extends GetView<SearchPageController> {
  const SearchIpt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        children: [
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 30,
              ),
              child: TextField(
                onChanged: (value) {
                  controller.changeInput(value);
                },
                autofocus: true,
                scrollPadding: EdgeInsets.zero,
                decoration: const InputDecoration(
                  hintText: "搜索帖子或者用户",
                  hintStyle: TextStyle(fontSize: 14),
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(0, 5, 15, 5),
                  fillColor: Color(0xfff2f4f5),
                  filled: true,
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    borderSide: BorderSide(
                      color: Color(0xfff2f4f5),
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    borderSide: BorderSide(
                      color: Color(0xfff2f4f5),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Text(
              '取消',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
