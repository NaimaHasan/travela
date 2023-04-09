import 'package:flutter/material.dart';

class PillButton extends StatelessWidget {
  const PillButton({Key? key, required this.text, required this.padding}) : super(key: key);

  final String text;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Padding(
        padding: padding,
        child: Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: 13),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.black, width: 0.5),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
