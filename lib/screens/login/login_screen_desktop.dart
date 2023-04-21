import 'package:flutter/material.dart';
import 'package:travela/screens/login/widgets/login_form.dart';
import '../../widgets/common/top_navigation_bar.dart';

class LogInScreenDesktop extends StatefulWidget {
  const LogInScreenDesktop({Key? key}) : super(key: key);

  @override
  _LogInScreenDesktopState createState() => _LogInScreenDesktopState();
}

class _LogInScreenDesktopState extends State<LogInScreenDesktop> {
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
