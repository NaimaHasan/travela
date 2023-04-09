import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'account_screen_desktop.dart';



class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);
  static const String routeName = '/account';

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const AccountScreenDesktop(),
      tablet: (BuildContext context) => const AccountScreenDesktop(),
      desktop: (BuildContext context) => const AccountScreenDesktop(),
    );
  }
}