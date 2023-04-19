import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:travela/screens/register/register_screen_desktop.dart';



class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const String routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const RegisterScreenDesktop(),
      tablet: (BuildContext context) => const RegisterScreenDesktop(),
      desktop: (BuildContext context) => const RegisterScreenDesktop(),
    );
  }
}