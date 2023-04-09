import 'package:flutter/material.dart';

class TopNavigationBarItem extends StatefulWidget {
  const TopNavigationBarItem({Key? key, required this.text, this.size = 18})
      : super(key: key);

  final String text;
  final double size;

  @override
  State<TopNavigationBarItem> createState() => _TopNavigationBarItemState();
}

class _TopNavigationBarItemState extends State<TopNavigationBarItem> {
  // late bool _isHovering;

  @override
  void initState() {
    super.initState();
    // _isHovering = false;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(fontSize: widget.size),
    );
  }
}
