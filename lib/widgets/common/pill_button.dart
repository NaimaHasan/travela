import 'package:flutter/material.dart';

//A stateless widget used for displaying the pill buttons used across the website
class PillButton extends StatelessWidget {
  //Constructor
  const PillButton({Key? key, required this.child, required this.padding, required this.onPress, this.color}) : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback onPress;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    //Elevated button for the pill button
    return ElevatedButton(
      onPressed: onPress,
      //Shaping the pill button
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
