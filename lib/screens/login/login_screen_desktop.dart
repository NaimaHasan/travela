import 'package:flutter/material.dart';
import '../../widgets/common/top_navigation_bar.dart';
import '../account/account_screen.dart';
import '../register/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogInScreenDesktop extends StatefulWidget {
  const LogInScreenDesktop({Key? key}) : super(key: key);

  @override
  _LogInScreenDesktopState createState() => _LogInScreenDesktopState();
}

class _LogInScreenDesktopState extends State<LogInScreenDesktop> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  var _userEmail = '';
  var _userPassword = '';
  final _formKey = GlobalKey<FormState>();

  void _submitAuthForm(String email, String password, BuildContext ctx) async {
    try {
      setState(
        () {
          _isLoading = true;
        },
      );

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.of(context).pop();
    } on FirebaseAuthException catch (err) {
      var message = 'An error occurred, please check your credentials!';

      if (err.message != null) {
        message = err.message!;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
      setState(
        () {
          _isLoading = false;
        },
      );
    } catch (err) {
      setState(
        () {
          _isLoading = false;
        },
      );
    }
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      _submitAuthForm(_userEmail.trim(), _userPassword.trim(), context);
    }
  }

  bool isObscured = true;
  var changeIcon = Icons.visibility_off_outlined;
  void initState() {
    isObscured = true;
    changeIcon = Icons.visibility_off_outlined;
    super.initState();
  }

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
              child: TextFormField(
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'Enter your E-mail',
                  labelStyle: const TextStyle(fontSize: 15),
                  errorStyle: const TextStyle(fontSize: 10),
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Invalid email!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _userEmail = value!;
                },
              ),
            ),
            Container(
              height: 30,
            ),
            SizedBox(
              width: 400,
              child: TextFormField(
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'Enter password',
                  labelStyle: const TextStyle(fontSize: 15),
                  errorStyle: const TextStyle(fontSize: 10),
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
                validator: (value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _userPassword = value!;
                },
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
                onPressed: () {
                  _trySubmit();
                  Navigator.of(context).pushNamed(AccountScreen.routeName);
                },
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
                  onPressed: () {
                    Navigator.of(context).pushNamed(RegisterScreen.routeName);
                  },
                  child: const Text('Register'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
