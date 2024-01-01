import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'account_screen_desktop.dart';
import 'account_screen_mobile.dart';

//A stateless widget for account screen
class AccountScreen extends StatelessWidget {
  //Constructor
  const AccountScreen({Key? key}) : super(key: key);
  static const String routeName = '/account';

  @override
  Widget build(BuildContext context) {
    //Routes to the respective widgets for each of the versions
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const AccountScreenMobile(),
      tablet: (BuildContext context) => const AccountScreenMobile(),
      desktop: (BuildContext context) => const AccountScreenDesktop(),
    );
  }
}