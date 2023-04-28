import 'package:flutter/material.dart';
import 'package:travela/common/api/authenticationController.dart';

import '../../../widgets/common/auth_form_field.dart';
import '../../register/register_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _isLoading = false;
  var _userEmail = '';
  var _userPassword = '';
  final _formKey = GlobalKey<FormState>();

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
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });

                await Authentication.login(
                  context,
                  _formKey,
                  _userEmail,
                  _userPassword,
                );

                setState(() {
                  _isLoading = false;
                });
              },
              child: _isLoading
                  ? CircularProgressIndicator()
                  : const Text(
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
