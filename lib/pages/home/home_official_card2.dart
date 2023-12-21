import 'package:flutter/material.dart';
import 'package:imitate_miyoushe/common/cache_image.dart';
import 'package:imitate_miyoushe/router/routes.dart';
import 'package:imitate_miyoushe/utils/format_time.dart';

class HomeOfficialCard2 extends StatelessWidget {
  final Map itemData;
  const HomeOfficialCard2({Key? key, required this.itemData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        MyRouter.push(
          MyRouter.articleDetails,
          {
            'id': itemData['post']['post_id'],
            'showType': itemData['post']['view_type'],
          },
        );
      },
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Container(
              height: 90,
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffebeff0),
                  ),
                ),
              ),
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemData['post']['subject'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${itemData['user']['nickname']} · ${formatTime(itemData['post']['created_at'])}',
                        style: const TextStyle(
                          color: Color(0xff999999),
                          fontSize: 13,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.textsms,
                            color: Color(0xff999999),
                            size: 14,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            '${itemData['stat']['reply_num']}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xff999999),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            clipBehavior: Clip.antiAlias,
            child: List.from(itemData['image_list']).isNotEmpty
                ? CacheImage(
                    imageUrl: itemData['image_list'][0]['url'],
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
