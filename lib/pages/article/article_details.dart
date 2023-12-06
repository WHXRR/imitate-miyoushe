import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/global.dart';

class ArticleDetails extends StatefulWidget {
  const ArticleDetails({Key? key}) : super(key: key);

  @override
  _ArticleDetailsState createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  GlobalController globalController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(Get.arguments);
    print(globalController.currentGameCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('文章详情页'),
      ),
    );
  }
}
