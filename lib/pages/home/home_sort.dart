import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeSort extends StatefulWidget {
  final bool isHot;
  final int sortType;
  final Function cb;
  const HomeSort({
    Key? key,
    required this.isHot,
    required this.sortType,
    required this.cb,
  }) : super(key: key);

  @override
  _HomeSortState createState() => _HomeSortState();
}

class _HomeSortState extends State<HomeSort> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    if (!widget.isHot) return;
                    widget.cb(false, 1);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.isHot
                        ? Colors.transparent
                        : const Color(0xfff2f4f5),
                    borderRadius: const BorderRadius.all(Radius.circular(23)),
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                  child: Text(
                    '最新',
                    style: TextStyle(
                      color:
                          widget.isHot ? const Color(0xff999999) : Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    if (widget.isHot) return;
                    widget.cb(true, 2);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.isHot
                        ? const Color(0xfff2f4f5)
                        : Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(23)),
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                  child: Text(
                    '热门',
                    style: TextStyle(
                      color:
                          widget.isHot ? Colors.black : const Color(0xff999999),
                    ),
                  ),
                ),
              ),
            ],
          ),
          widget.isHot
              ? Container()
              : InkWell(
                  onTap: () {
                    setState(() {
                      var type = widget.sortType == 1 ? 2 : 1;
                      widget.cb(false, type);
                    });
                  },
                  child: Row(
                    children: [
                      const Text(
                        '回复时间排序',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            'images/arrow.svg',
                            semanticsLabel: 'Acme Logo',
                            height: 6,
                            color: widget.sortType == 1
                                ? const Color(0xff00bbff)
                                : const Color(0xff999999),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          RotatedBox(
                            quarterTurns: 2,
                            child: SvgPicture.asset(
                              'images/arrow.svg',
                              semanticsLabel: 'Acme Logo',
                              height: 6,
                              color: widget.sortType == 2
                                  ? const Color(0xff00bbff)
                                  : const Color(0xff999999),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
