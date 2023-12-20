import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/user.dart';

class UserContainer extends GetView<UserController> {
  const UserContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Color(0xffebeff0),
            ),
          ),
        ),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                controller.listType.value = 0;
                controller.getData(UserListType.userPost);
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 3,
                      color: controller.listType.value == 0
                          ? const Color(0xffffe14c)
                          : Colors.transparent,
                    ),
                  ),
                ),
                child: Text(
                  '发帖',
                  style: controller.listType.value == 0
                      ? const TextStyle(
                          color: Color(0xff333333),
                          fontWeight: FontWeight.bold,
                        )
                      : const TextStyle(
                          color: Color(0xff999999),
                        ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.listType.value = 1;
                controller.getData(UserListType.userReply);
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 3,
                      color: controller.listType.value == 1
                          ? const Color(0xffffe14c)
                          : Colors.transparent,
                    ),
                  ),
                ),
                child: Text(
                  '回复',
                  style: controller.listType.value == 1
                      ? const TextStyle(
                          color: Color(0xff333333),
                          fontWeight: FontWeight.bold,
                        )
                      : const TextStyle(
                          color: Color(0xff999999),
                        ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.listType.value = 2;
                controller.getData(UserListType.userFavouritePost);
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 3,
                      color: controller.listType.value == 2
                          ? const Color(0xffffe14c)
                          : Colors.transparent,
                    ),
                  ),
                ),
                child: Text(
                  '收藏',
                  style: controller.listType.value == 2
                      ? const TextStyle(
                          color: Color(0xff333333),
                          fontWeight: FontWeight.bold,
                        )
                      : const TextStyle(
                          color: Color(0xff999999),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
