import 'package:flutter/material.dart';
import 'package:travela/screens/register/widgets/register_form.dart';

import '../../widgets/common/top_navigation_bar.dart';


class RegisterScreenDesktop extends StatelessWidget {
  //Constructor
  const RegisterScreenDesktop({
  super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 80),
        child: const TopNavigationBar(
          hasSearch: false,
          hasAccount: false,
        ),
      ),
      body: const Center(
        child: RegisterForm(),
      ),
    );
  }
}
