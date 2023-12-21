import 'package:flutter/material.dart';
import 'package:imitate_miyoushe/common/cache_image.dart';
import 'package:imitate_miyoushe/router/routes.dart';

class CosCard extends StatelessWidget {
  final Map cardData;
  final Map currentTab;
  const CosCard({Key? key, required this.cardData, required this.currentTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0), // Adjust the value as needed
      ),
      child: InkWell(
        onTap: () {
          MyRouter.push(
            MyRouter.articleDetails,
            {
              'id': cardData['post']['post_id'],
              'showType': cardData['post']['view_type'],
            },
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              child: CacheImage(
                imageUrl: cardData['post']['cover'],
                memCacheWidth: 500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                '${cardData['post']['subject']}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Container(
                          width: 26,
                          height: 26,
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                color: const Color(0xffebeff0),
                              )),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                Image.network(cardData['user']['avatar_url'])
                                    .image,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${cardData['user']['nickname']}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xff999999),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: const Icon(
                      Icons.thumb_up_outlined,
                      color: Color(0xff999999),
                      size: 17,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
