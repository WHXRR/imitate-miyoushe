import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class HeroPage extends StatefulWidget {
  const HeroPage({Key? key}) : super(key: key);

  @override
  _HeroPageState createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Hero(
        tag: Get.arguments['url'],
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: PhotoView(
              imageProvider: NetworkImage(Get.arguments['url']),
            ),
          ),
        ),
      ),
    );
  }
}
