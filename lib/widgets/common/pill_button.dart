import 'package:flutter/material.dart';

class PillButton extends StatelessWidget {
  const PillButton({Key? key, required this.child, required this.padding, required this.onPress}) : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Padding(
        padding: padding,
        child: child,
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
