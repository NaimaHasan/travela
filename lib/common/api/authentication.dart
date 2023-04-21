import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../screens/account/account_screen.dart';


class Authentication{
  static Future<void> register(BuildContext context, GlobalKey<FormState> formKey, String userName, String userEmail, String userPassword) async {
    final isValid = formKey.currentState!.validate();
    final auth = FirebaseAuth.instance;

    FocusScope.of(context).unfocus();

    if (isValid) {
      formKey.currentState!.save();

      try {
        await auth.createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword,
        );

        await http.post(
          Uri.http('127.0.0.1:8000', 'users/'),
          body: {
            'userID': auth.currentUser!.uid,
            'userName': userName
          },
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
      } catch (err) {
        if (kDebugMode) {
          print(err);
        }
      }
    }
  }
}