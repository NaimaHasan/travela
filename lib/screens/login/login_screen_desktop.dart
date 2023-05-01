import 'package:flutter/material.dart';
import 'package:travela/screens/login/widgets/login_form.dart';
import '../../widgets/common/top_navigation_bar.dart';

class LogInScreenDesktop extends StatelessWidget {
  const LogInScreenDesktop({Key? key}) : super(key: key);

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
      body: Center(
        child: LoginForm(),
      ),
    );
  }
}
