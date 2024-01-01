import 'package:flutter/material.dart';
import 'package:travela/screens/login/widgets/login_form.dart';
import '../../widgets/common/top_navigation_bar.dart';

//A stateless widget that displays the log in screen desktop
class LogInScreenDesktop extends StatelessWidget {
  //Constructor
  const LogInScreenDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 80),
        //Calls the TopNavigationBar widget
        child: const TopNavigationBar(
          hasSearch: false,
          hasAccount: false,
        ),
      ),
      body: const Center(
        //Calls the LoginForm widget
        child: LoginForm(),
      ),
    );
  }
}
