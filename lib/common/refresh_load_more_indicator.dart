import 'dart:async';

import 'package:flutter/material.dart';
import './scroll_to_top.dart';

enum LoadingMoreState {
  loading, // 正在加载时
  complete, // 加载完成
  fail, // 加载失败
  noData, // 没有更多数据了
  hide, // 隐藏布局
}

class RefreshLoadMoreIndicator extends StatefulWidget {
  final int itemCount;
  final Future<LoadingMoreState> Function() onLoadMore;
  final Function(BuildContext, int) itemBuilder;
  final Future<void> Function() onRefresh;
  final bool removePadding;

  const RefreshLoadMoreIndicator({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    required this.onLoadMore,
    required this.onRefresh,
    this.removePadding = false,
  }) : super(key: key);

  @override
  _RefreshLoadMoreIndicatorState createState() =>
      _RefreshLoadMoreIndicatorState();
}

class _RefreshLoadMoreIndicatorState extends State<RefreshLoadMoreIndicator> {
  ScrollController _scrollController = ScrollController();
  LoadingMoreState _loadingMoreState = LoadingMoreState.hide;

  Widget _buildFootView(String text) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _loadingMoreState == LoadingMoreState.loading
              ? const SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xffffe14c),
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: const TextStyle(color: Color(0xff999999)),
            ),
          )
        ],
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // 如果处于非 LoadingMoreState.hide 状态，都不能再来第二次，否则会出现重复请求
        if (_loadingMoreState == LoadingMoreState.loading ||
            _loadingMoreState == LoadingMoreState.complete ||
            _loadingMoreState == LoadingMoreState.noData ||
            _loadingMoreState == LoadingMoreState.fail) {
          return;
        }
        // 把状态调整为 LoadingMoreState.loading，此时就会显示正在加载的布局
        setState(() {
          _loadingMoreState = LoadingMoreState.loading;
        });
        // 拿到使用者返回的加载状态
        Future<LoadingMoreState> future = widget.onLoadMore();
        future.then((state) {
          setState(() {
            _loadingMoreState = state;
          });
          // 展示500ms的布局后再隐藏 footView 布局
          Timer(const Duration(milliseconds: 500), () {
            setState(() {
              _loadingMoreState = LoadingMoreState.hide;
            });
          });
        });
      }
    });
  }

  listView() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.itemCount + 1,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == widget.itemCount) {
          if (_loadingMoreState == LoadingMoreState.loading) {
            return _buildFootView("正在加载...");
          } else if (_loadingMoreState == LoadingMoreState.complete) {
            return _buildFootView("加载完成");
          } else if (_loadingMoreState == LoadingMoreState.fail) {
            return _buildFootView('加载失败');
          } else if (_loadingMoreState == LoadingMoreState.noData) {
            return _buildFootView('已经到底啦');
          } else {
            return Container();
          }
        }
        // 依然还是用使用者给的 item 布局，只是在此之前我们做了关于 footView 的处理。
        return widget.itemBuilder(context, index);
      },
    );
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: widget.onRefresh,
          child: Scrollbar(
            child: widget.removePadding
                ? MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: listView(),
                  )
                : listView(),
          ),
        ),
        Positioned(
          right: 20,
          bottom: 50,
          child: ScrollToTop(
            scrollController: _scrollController,
          ),
        )
      ],
    );
  }
}
