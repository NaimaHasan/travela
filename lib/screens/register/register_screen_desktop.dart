import 'package:flutter/material.dart';
import 'package:travela/screens/register/widgets/register_form.dart';

import '../../widgets/common/top_navigation_bar.dart';

//A stateless widget for displaying the register screen desktop
class RegisterScreenDesktop extends StatelessWidget {
  //Constructor
  const RegisterScreenDesktop({
  super.key,
  });

  @override
  Widget build(BuildContext context) {
    //Variable for screen size
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 80),
        //Calls TopNavigationBar widget
        child: const TopNavigationBar(
          hasSearch: false,
          hasAccount: false,
        ),
      ),
      //Calls RegisterForm widget
      body: const Center(
        child: RegisterForm(),
      ),
    );
  }
}
