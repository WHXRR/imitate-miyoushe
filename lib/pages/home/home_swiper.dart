import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/controllers/home.dart';
import 'package:imitate_miyoushe/common/cache_image.dart';

class HomeSwiper extends StatefulWidget {
  const HomeSwiper({Key? key}) : super(key: key);

  @override
  _HomeSwiperState createState() => _HomeSwiperState();
}

class _HomeSwiperState extends State<HomeSwiper> {
  int _currentIndex = 0;
  List _list = [];
  late PageController _pageController;
  late Timer _timer;
  HomeController homeController = Get.find();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 3), (t) {
      _pageController.animateToPage((_currentIndex + 1) % _list.length,
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: homeController.bannerData.isNotEmpty
            ? [
                Container(
                  padding: const EdgeInsets.all(5),
                  height: 180,
                  color: const Color(0xfff2f4f5),
                  child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (value) {
                        setState(() {
                          _currentIndex = value % _list.length;
                        });
                      },
                      itemCount: 1000,
                      itemBuilder: (context, index) {
                        _list = homeController.bannerData.map((item) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: CacheImage(
                              imageUrl: item['cover'],
                            ),
                          );
                        }).toList();
                        return _list[index % _list.length];
                      }),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 15,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(homeController.bannerData.length,
                          (index) {
                        return Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == _currentIndex
                                ? Colors.white
                                : Colors.white70,
                          ),
                        );
                      })),
                )
              ]
            : [],
      ),
    );
  }
}
