import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  final String? tips;
  const Empty({Key? key, this.tips = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 50),
          width: 200,
          child: Image.asset(
            'images/empty.png',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          tips!,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xffcccccc),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
