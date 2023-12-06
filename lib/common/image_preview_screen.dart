import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImagePreviewScreen extends StatelessWidget {
  final List<String> imageUrls;
  final int initialIndex;

  ImagePreviewScreen({required this.imageUrls, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        body: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          itemCount: imageUrls.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(imageUrls[index]),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            );
          },
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          pageController: PageController(initialPage: initialIndex),
        ),
      ),
    );
  }
}
