import 'package:flutter/material.dart';
import 'package:imitate_miyoushe/common/cache_image.dart';
import 'package:imitate_miyoushe/router/routes.dart';

class HomeOfficialCard1 extends StatelessWidget {
  final Map itemData;
  const HomeOfficialCard1({Key? key, required this.itemData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: InkWell(
        onTap: () {
          MyRouter.push(
            MyRouter.articleDetails,
            {
              'id': itemData['post']['post_id'],
              'showType': itemData['post']['view_type'],
            },
          );
        },
        child: Column(
          children: [
            SizedBox(
              height: 150,
              width: double.infinity,
              child: List.from(itemData['image_list']).isNotEmpty
                  ? CacheImage(
                      imageUrl: itemData['image_list'][0]['url'],
                    )
                  : Container(),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(itemData['post']['subject']),
            )
          ],
        ),
      ),
    );
  }
}
