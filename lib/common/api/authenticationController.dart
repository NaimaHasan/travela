import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:travela/screens/login/login_screen.dart';

import '../../screens/account/account_screen.dart';

class Authentication {
  static Future<void> register(BuildContext context, String userName,
      String userEmail, String userPassword) async {
    final auth = FirebaseAuth.instance;

    try {
      await auth.createUserWithEmailAndPassword(
        email: userEmail.trim(),
        password: userPassword,
      );

      await http.post(
        Uri.http('127.0.0.1:8000', 'users/'),
        body: {'userEmail': userEmail.trim(), 'userName': userName},
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

  static Future<void> login(BuildContext context, GlobalKey<FormState> formKey,
      String userEmail, String userPassword) async {
    final auth = FirebaseAuth.instance;

    try {
      await auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
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

  static Future<void> logout(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    FocusScope.of(context).unfocus();
    auth.signOut();

    if (context.mounted) {
      Navigator.of(context).pushNamed(LogInScreen.routeName);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logged out successfully'),
      ),
    );
  }
}
