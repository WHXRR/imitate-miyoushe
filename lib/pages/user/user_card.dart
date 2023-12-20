import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/user.dart';

class UserCard extends GetView<UserController> {
  const UserCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 20),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -45,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundImage: Image.network(
                            controller.userInfo['user_info']['avatar_url'])
                        .image,
                    radius: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '通行证ID：${controller.userInfo['user_info']['uid']}',
                    style: const TextStyle(
                      color: Color(0xff666666),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  controller.userInfo['user_info']['nickname'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                controller.userInfo['user_info']['certification']['type'] == 0
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            controller.userInfo['user_info']['certification']
                                        ['type'] ==
                                    2
                                ? Image.asset(
                                    'images/geren.png',
                                    width: 16,
                                    height: 16,
                                  )
                                : Container(),
                            controller.userInfo['user_info']['certification']
                                        ['type'] ==
                                    1
                                ? Image.asset(
                                    'images/guanfang.png',
                                    width: 16,
                                    height: 16,
                                  )
                                : Container(),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              controller.userInfo['user_info']['certification']
                                  ['label'],
                              style: const TextStyle(
                                color: Color(0xff666666),
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'images/qianming.png',
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          controller.userInfo['user_info']['introduce'] == ''
                              ? '系统原装签名，送给每一位小可爱~'
                              : controller.userInfo['user_info']['introduce'],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xff666666),
                            fontSize: 13,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Image.asset(
                        'images/ip.png',
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'IP属地：${controller.userInfo['user_info']['ip_region']}',
                        style: const TextStyle(
                          color: Color(0xff666666),
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  margin: const EdgeInsets.only(top: 10),
                  color: const Color(0xfff6f6f6),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${controller.userInfo['user_info']['achieve']['followed_cnt']} 粉丝',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${controller.userInfo['user_info']['achieve']['follow_cnt']} 关注',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${controller.userInfo['user_info']['achieve']['like_num']} 获赞',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
