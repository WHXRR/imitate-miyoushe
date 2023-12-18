import 'package:get/get.dart';

import 'package:imitate_miyoushe/pages/index/index.dart';
import 'package:imitate_miyoushe/pages/article/article_details.dart';
import 'package:imitate_miyoushe/pages/article/comment_details.dart';
import 'package:imitate_miyoushe/pages/search/search.dart';
import 'package:imitate_miyoushe/pages/topics/topics.dart';

import 'package:imitate_miyoushe/binding/index.dart';
import 'package:imitate_miyoushe/binding/article_details.dart';
import 'package:imitate_miyoushe/binding/comment_details.dart';
import 'package:imitate_miyoushe/binding/search.dart';
import 'package:imitate_miyoushe/binding/topics.dart';

class MyRouter {
  static const String home = "/";
  static const String articleDetails = "/articleDetails";
  static const String commentDetails = "/commentDetails";
  static const String search = "/search";
  static const String topics = "/topics";

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
    GetPage(
      name: commentDetails,
      page: () => const CommentDetails(),
      binding: CommentDetailsBinding(),
    ),
    GetPage(
      name: search,
      page: () => const Search(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: topics,
      page: () => const Topics(),
      binding: TopicsBinding(),
    ),
  ];
}
