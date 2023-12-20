import 'package:flutter/material.dart';
import 'package:imitate_miyoushe/common/empty.dart';
import 'package:imitate_miyoushe/common/permissions.dart';

class WrapUser extends StatelessWidget {
  final bool isEmpty;
  final bool hasPermissions;
  final Widget itemWidget;
  const WrapUser({
    Key? key,
    required this.itemWidget,
    required this.isEmpty,
    required this.hasPermissions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (hasPermissions) {
      return const Permissions(
        tips: '用户已设为隐私',
      );
    } else if (isEmpty) {
      return const Empty(
        tips: '暂时没有帖子哟',
      );
    } else {
      return itemWidget;
    }
  }
}
