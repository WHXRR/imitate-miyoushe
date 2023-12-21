import 'package:flutter/material.dart';
import 'package:imitate_miyoushe/utils/format_time.dart';
import 'package:imitate_miyoushe/router/routes.dart';

class UserReply extends StatelessWidget {
  final Map itemData;
  const UserReply({Key? key, required this.itemData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var timeList = formatTime(itemData['reply']['created_at']).split('-');
    var day = timeList[2];
    var month = timeList[1];
    var year = timeList[0];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          MyRouter.push(
            MyRouter.articleDetails,
            {
              'id': itemData['r_post']['post_id'],
              'showType': itemData['r_post']['view_type'],
            },
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                      child: Image.asset(
                        'images/shizhong.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            day,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xffcccccc),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            '$month月/$year年',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xffcccccc),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Text(
                  itemData['reply']['content'],
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xfff7f9fa),
                  ),
                  child: Text(
                    '回复帖子：${itemData['r_post']['subject']}',
                    style: const TextStyle(
                      color: Color(0xff999999),
                      fontSize: 13,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
