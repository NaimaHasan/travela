import 'package:flutter/material.dart';

class TopNavigationBarItem extends StatelessWidget {
  const TopNavigationBarItem(
      {Key? key, required this.text, this.size = 18, required this.route})
      : super(key: key);

  final String text;
  final double size;
  final String route;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Text(
        text,
        style: TextStyle(fontSize: size, color: Colors.black),
      ),
    );
  }
}
