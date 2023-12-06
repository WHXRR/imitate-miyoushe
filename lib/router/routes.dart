import 'package:get/get.dart';

import 'package:imitate_miyoushe/pages/index/index.dart';
import 'package:imitate_miyoushe/pages/article/article_details.dart';

import 'package:imitate_miyoushe/binding/index.dart';
import 'package:imitate_miyoushe/binding/article_details.dart';

class MyRouter {
  static const String home = "/";
  static const String articleDetails = "/articleDetails";

  static const String login = "/login";
  static const String register = "/register";

  static push(String page, [dynamic arguments]) {
    return Get.toNamed(page, arguments: arguments);
  }

  static final routes = [
    GetPage(
      name: home,
      page: () => Index(),
      binding: IndexBinding(),
    ),
    GetPage(
      name: articleDetails,
      page: () => const ArticleDetails(),
      binding: ArticleDetailsBinding(),
    ),
  ];
}
