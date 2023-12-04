import 'package:flutter/material.dart';

class ScrollToTop extends StatefulWidget {
  final ScrollController scrollController;
  final double scrollThreshold;
  const ScrollToTop({
    Key? key,
    required this.scrollController,
    this.scrollThreshold = 300,
  }) : super(key: key);

  @override
  _ScrollToTopState createState() => _ScrollToTopState();
}

class _ScrollToTopState extends State<ScrollToTop> {
  bool _isVisible = false;

  void _scrollListener() {
    if (widget.scrollController.offset >= widget.scrollThreshold &&
        !_isVisible) {
      setState(() {
        _isVisible = true;
      });
    } else if (widget.scrollController.offset < widget.scrollThreshold &&
        _isVisible) {
      setState(() {
        _isVisible = false;
      });
    }
  }

  void _scrollToTop() {
    widget.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isVisible
        ? InkWell(
            onTap: _scrollToTop,
            child: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: const Color(0xffffe14c),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          )
        : Container();
  }
}
