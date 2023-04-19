import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travela/widgets/common/auth_form_field.dart';

import '../../account/account_screen.dart';
import '../../login/login_screen.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final _auth = FirebaseAuth.instance;

  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  bool _isLoading = false;

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      UserCredential authResult;

      try {
        setState(() {
          _isLoading = true;
        });

        authResult = await _auth.createUserWithEmailAndPassword(
          email: _userEmail,
          password: _userPassword,
        );

        if (context.mounted) {
          Navigator.of(context).pushNamed(AccountScreen.routeName);
        }
      } on FirebaseAuthException catch (err) {
        var message = 'An error occurred, please check your credentials!';

        if (err.message != null) {
          message = err.message!;
        }

        ScaffoldMessenger.of(context).showSnackBar(
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
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Welcome Onboard!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Container(
            height: 60,
          ),
          AuthFormField(
            text: 'Enter your full name',
            validatorFn: (value) {
              if (value!.isEmpty || value.length < 4) {
                return 'Please enter at least 4 characters';
              }
              return null;
            },
            savedFn: (value) {
              _userName = value!;
            },
          ),
          Container(
            height: 30,
          ),
          AuthFormField(
            text: 'Enter your E-mail',
            validatorFn: (value) {
              if (value!.isEmpty || !value.contains('@')) {
                return 'Invalid email!';
              }
              return null;
            },
            savedFn: (value) {
              _userEmail = value!;
            },
          ),
          Container(
            height: 30,
          ),
          AuthFormField(
            text: 'Enter password',
            validatorFn: (value) {
              if (value!.isEmpty || value.length < 5) {
                return 'Password is too short!';
              }
              return null;
            },
            savedFn: (value) {
              _userPassword = value!;
            },
            controller: _controller,
          ),
          Container(
            height: 30,
          ),
          AuthFormField(
            text: 'Confirm Password',
            validatorFn: (value) {
              if (value!.isEmpty || value.length < 5) {
                return 'Password is too short!';
              }
              if (value != _controller.text) {
                return 'Passwords do not match!';
              }
              return null;
            },
            savedFn: (value) {},
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
              },
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
                onPressed: () {
                  Navigator.of(context).pushNamed(LogInScreen.routeName);
                },
                child: Text('Log In'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
