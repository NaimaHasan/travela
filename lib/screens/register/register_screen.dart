import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:travela/screens/register/register_screen_desktop.dart';



class RegisterScreen extends StatelessWidget {
  //Constructor
  const RegisterScreen({Key? key}) : super(key: key);
  static const String routeName = '/register';

  @override
  Widget build(BuildContext context) {
    //Routes to the respective widgets for each of the versions
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const RegisterScreenDesktop(),
      tablet: (BuildContext context) => const RegisterScreenDesktop(),
      desktop: (BuildContext context) => const RegisterScreenDesktop(),
    );
  }
}