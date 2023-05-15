import 'package:flutter/material.dart';

class PillButton extends StatelessWidget {
  //Constructor
  const PillButton({Key? key, required this.child, required this.padding, required this.onPress, this.color}) : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback onPress;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.black, width: 0.5),
        ),
        backgroundColor: color ?? Colors.white,
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
