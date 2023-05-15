import 'package:flutter/material.dart';
import 'package:travela/common/api/authentication_controller.dart';

import '../../../widgets/common/auth_form_field.dart';
import '../../register/register_screen.dart';

//A stateful widget for log in form
class LoginForm extends StatefulWidget {
  //Constructor
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
          //Calls the AuthFormField for email
          AuthFormField(
            text: 'Enter your E-mail',
            width: 400,
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
          //Calls the AuthFormField for password
          AuthFormField(
            text: 'Enter password',
            width: 400,
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
          //Displays the elevated button with "log in" written in it
          SizedBox(
            width: 300,
            height: 60,
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });

                final isValid = _formKey.currentState!.validate();
                FocusScope.of(context).unfocus();

                if (isValid) {
                  _formKey.currentState!.save();

                  await Authentication.login(
                    context,
                    _formKey,
                    _userEmail,
                    _userPassword,
                  );
                }

                setState(() {
                  _isLoading = false;
                });
              },
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
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
              //Displays the text button for register that routes to register screen
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
