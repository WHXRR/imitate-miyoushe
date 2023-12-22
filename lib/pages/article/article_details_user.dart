import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/article_details.dart';
import 'package:imitate_miyoushe/router/routes.dart';

class ArticleDetailsUser extends GetView<ArticleDetailsController> {
  const ArticleDetailsUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                MyRouter.push(MyRouter.user, {
                  "id": controller.articleData['user']['uid'],
                });
              },
              child: Container(
                width: 35,
                height: 35,
                margin: const EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: Image.network(
                          controller.articleData['user']['avatar_url'])
                      .image,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${controller.articleData['user']['nickname']}',
                      style: const TextStyle(
                          color: Color(0xff404040), fontSize: 12),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 3),
                      padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                      decoration: BoxDecoration(
                        color: const Color(0xffffbf00),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        'lv ${controller.articleData['user']['level_exp']['level']}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 7,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.from(
                          controller.articleData['user']['certifications'])
                      .map(
                    (item) {
                      return Text(
                        '${item['label']}   ',
                        style: const TextStyle(fontSize: 8, color: Colors.grey),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          ],
        ),
        ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(1, 1),
                backgroundColor: const Color(0xff00b2ff),
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                )),
            icon: const Icon(
              Icons.add,
              size: 15,
            ),
            label: const Text('关注'))
      ],
    );
  }
}
