import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/user.dart';
import 'user_top.dart';
import 'user_card.dart';
import 'user_container.dart';
import 'user_post.dart';
import 'user_reply.dart';
import 'wrap_user.dart';
import 'package:imitate_miyoushe/pages/article/home_article.dart';
import 'package:imitate_miyoushe/common/refresh_load_more_indicator.dart';

class User extends GetView<UserController> {
  const User({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.userInfo.isNotEmpty
          ? Container(
              color: Colors.white,
              child: Stack(
                children: [
                  const UserTop(),
                  Positioned(
                    top: 40 + Get.mediaQuery.padding.top,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: RefreshLoadMoreIndicator(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => Column(
                            children: [
                              const UserCard(),
                              const UserContainer(),
                              controller.listType.value == 0
                                  ? WrapUser(
                                      isEmpty: List.from(controller
                                              .userData['userPostList'])
                                          .isEmpty,
                                      hasPermissions:
                                          controller.userData['userPostData'] ==
                                              null,
                                      itemWidget: Container(
                                        color: const Color(0xfff2f4f5),
                                        child: Column(
                                          children: List.from(controller
                                                  .userData['userPostList'])
                                              .map((item) {
                                            var imgLists = List.from(
                                                    item['image_list'])
                                                .map((e) => e['url'].toString())
                                                .toList();
                                            return UserPost(
                                              itemData: item,
                                              imgLists: imgLists,
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              controller.listType.value == 1
                                  ? WrapUser(
                                      isEmpty: List.from(controller
                                              .userData['userReplyList'])
                                          .isEmpty,
                                      hasPermissions:
                                          controller.userData['userReplyData']
                                                  ['isNull'] !=
                                              null,
                                      itemWidget: Container(
                                        color: const Color(0xfff2f4f5),
                                        child: Column(
                                          children: List.from(controller
                                                  .userData['userReplyList'])
                                              .map((item) => UserReply(
                                                    itemData: item,
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              controller.listType.value == 2
                                  ? WrapUser(
                                      isEmpty: List.from(controller.userData[
                                              'userFavouritePostList'])
                                          .isEmpty,
                                      hasPermissions: controller.userData[
                                                  'userFavouritePostData']
                                              ['isNull'] !=
                                          null,
                                      itemWidget: Container(
                                        color: const Color(0xfff2f4f5),
                                        child: Column(
                                          children: List.from(
                                                  controller.userData[
                                                      'userFavouritePostList'])
                                              .map((item) => HomeArticle(
                                                    itemData: item,
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        );
                      },
                      onLoadMore: () async {
                        UserListType type;
                        if (controller.listType.value == 0) {
                          type = UserListType.userPost;
                        } else if (controller.listType.value == 1) {
                          type = UserListType.userReply;
                        } else {
                          type = UserListType.userFavouritePost;
                        }
                        return controller.getData(type);
                      },
                      onRefresh: () async {
                        UserListType type;
                        if (controller.listType.value == 0) {
                          type = UserListType.userPost;
                          controller.userData['userPostData'] = {};
                          controller.userData['userPostList'] = [];
                        } else if (controller.listType.value == 1) {
                          type = UserListType.userReply;
                          controller.userData['userReplyData'] = {};
                          controller.userData['userReplyList'] = [];
                        } else {
                          type = UserListType.userFavouritePost;
                          controller.userData['userFavouritePostData'] = {};
                          controller.userData['userFavouritePostList'] = [];
                        }
                        controller.getData(type);
                      },
                    ),
                  )
                ],
              ),
            )
          : Container(),
    );
  }
}
