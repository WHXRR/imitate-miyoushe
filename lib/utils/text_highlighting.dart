import 'package:flutter/material.dart';

formatText(String str, keyword) {
  var strs = str.split(keyword);
  var widgets = strs.map((e) {
    return TextSpan(
      text: e,
      style: const TextStyle(
        fontSize: 15,
        color: Colors.black,
      ),
    );
  }).toList();
  List<InlineSpan> list = [];
  for (var i = 0; i < widgets.length; i++) {
    if (i == widgets.length - 1) {
      list.addAll([widgets[i]]);
    } else {
      list.addAll([
        widgets[i],
        TextSpan(
          text: keyword,
          style: const TextStyle(
            color: Color(0xff00c3ff),
            fontSize: 15,
          ),
        )
      ]);
    }
  }
  return Text.rich(
    TextSpan(
      children: list,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
