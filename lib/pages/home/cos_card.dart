import 'package:flutter/material.dart';
import 'package:imitate_miyoushe/common/cache_image.dart';

class CosCard extends StatelessWidget {
  final Map cardData;
  const CosCard({Key? key, required this.cardData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0), // Adjust the value as needed
      ),
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: CacheImage(
                            imageUrl: cardData['user']['avatar_url'],
                          ),
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
    );
  }
}
