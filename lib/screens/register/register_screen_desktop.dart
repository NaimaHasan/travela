import 'package:flutter/material.dart';

import '../../widgets/common/top_navigation_bar.dart';

class RegisterScreenDesktop extends StatelessWidget {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome Onbaord!',
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
                  labelText: 'Enter your full name',
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
                  labelText: 'Confirm password',
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
              height: 60,
            ),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Register',
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
                  'Already have an account?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Log In'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
