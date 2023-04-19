import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../widgets/common/auth_form_field.dart';
import '../../account/account_screen.dart';
import '../../register/register_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  var _userEmail = '';
  var _userPassword = '';
  final _formKey = GlobalKey<FormState>();

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      try {
        setState(() {
          _isLoading = true;
        });

        await _auth.signInWithEmailAndPassword(
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
            'Welcome Back!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Container(
            height: 60,
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
            isObscurable: true,
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
    );
  }
}
