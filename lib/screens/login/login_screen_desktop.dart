import 'package:flutter/material.dart';

class LogInScreenDesktop extends StatefulWidget {
  const LogInScreenDesktop({Key? key}) : super(key: key);

  @override
  _LogInScreenDesktopState createState() => _LogInScreenDesktopState();
}

class _LogInScreenDesktopState extends State<LogInScreenDesktop> {
  bool isObscured = true;
  var changeIcon = Icons.visibility_off_outlined;
  void initState() {
    isObscured = true;
    changeIcon = Icons.visibility_off_outlined;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome Back!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Container(
              height: 60,
            ),
            SizedBox(
              width: 400,
              child: TextField(
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'Enter your E-mail',
                  labelStyle: const TextStyle(
                    fontSize: 15,
                  ),
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
            Container(
              height: 30,
            ),
            SizedBox(
              width: 400,
              child: TextField(
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'Enter password',
                  labelStyle: const TextStyle(
                    fontSize: 15,
                  ),
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(
                        () {
                          isObscured = !isObscured;
                          if (changeIcon == Icons.visibility_outlined) {
                            changeIcon = Icons.visibility_off_outlined;
                          } else {
                            changeIcon = Icons.visibility_outlined;
                          }
                        },
                      );
                    },
                    icon: Icon(changeIcon),
                    iconSize: 16,
                  ),
                ),
                obscureText: isObscured,
              ),
            ),
            Container(
              height: 60,
            ),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Log In',
                  style: TextStyle(),
                ),
              ),
            ),
            Container(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Register'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
