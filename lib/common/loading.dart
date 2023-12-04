import 'package:flutter/material.dart';

class Loading {
  static OverlayEntry? _overlayEntry;

  static void showLoading(BuildContext context) {
    hideLoading();
    _overlayEntry = createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hideLoading() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  static OverlayEntry createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
          color: Colors.black.withOpacity(0.3),
          child: const Center(
            child: CircularProgressIndicator(
              color: Color(0xffffe14c),
            ),
          ),
        ),
      ),
    );
  }
}
// class Loading extends StatefulWidget {
//   const Loading({Key? key}) : super(key: key);

//   @override
//   LoadingState createState() => LoadingState();
// }

// class LoadingState extends State<Loading> {
//   OverlayEntry? _overlayEntry;

//   showLoading() {
//     Future.delayed(Duration.zero, () {
//       Overlay.of(context).insert(_overlayEntry!);
//     });
//   }

//   removeLoading() {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
