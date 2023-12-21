import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class CacheImage extends GetView {
  final String imageUrl;
  final BoxFit fit;
  final int? memCacheWidth;
  const CacheImage({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.memCacheWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit,
      memCacheWidth: memCacheWidth,
      placeholder: (context, url) {
        return const Padding(
          padding: EdgeInsets.all(5),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xffffe14c),
              ),
            ),
          ),
        );
      },
      imageUrl: imageUrl,
    );
  }
}
