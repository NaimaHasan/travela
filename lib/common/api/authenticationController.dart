import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:travela/screens/login/login_screen.dart';

import '../../screens/account/account_screen.dart';

class Authentication {
  //Function for registering a new account
  static Future<void> register(BuildContext context, String userName,
      String userEmail, String userPassword) async {
    final auth = FirebaseAuth.instance;

    try {
      //Creates user with e-mail and password in firebase
      await auth.createUserWithEmailAndPassword(
        email: userEmail.trim(),
        password: userPassword,
      );

      //Posts user credentials in django backend
      await http.post(
        Uri.http('127.0.0.1:8000', 'users/'),
        body: {
          'userEmail': userEmail.trim(),
          'userName': userName,
        },
      );

      //If the user is created, navigates to user account screen
      if (context.mounted) {
        Navigator.of(context).pushNamed(AccountScreen.routeName);
      }
    } on FirebaseAuthException catch (err) {
      var message = 'An error occurred, please check your credentials!';

      //If there is an error while registering for the account, stores the message
      if (err.message != null) {
        message = err.message!;
      }

      //Displays the error message using a snackbar
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


  //Function for logging into an account
  static Future<void> login(BuildContext context, GlobalKey<FormState> formKey,
      String userEmail, String userPassword) async {
    final auth = FirebaseAuth.instance;

    try {
      //Tries to log in to the account with given credentials in firebase
      await auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      //if logs in successfully, routes to account screen
      if (context.mounted) {
        Navigator.of(context).pushNamed(AccountScreen.routeName);
      }
    } on FirebaseAuthException catch (err) {
      var message = 'An error occurred, please check your credentials!';

      //if there is an error message, stores the error message
      if (err.message != null) {
        message = err.message!;
      }

      //Displays the error message using a snackbar
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

  //Function for logging out of an account
  static Future<void> logout(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    FocusScope.of(context).unfocus();

    //Signs out of firebase
    auth.signOut();

    //If signed out navigates to log in screen
    if (context.mounted) {
      Navigator.of(context).pushNamed(LogInScreen.routeName);
    }

    //Displays snackbar saying log out is successful
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logged out successfully'),
      ),
    );
  }

  //Function for changing password
  static Future<void> changePassword(BuildContext context, String oldPassword, String newPassword) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      //Checks if the old password provided matches with the password stored in firebase
      AuthCredential credentials =
      EmailAuthProvider.credential(
          email: user!.email!, password: oldPassword);

      await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(credentials);

      //if the old passowrd matches, updates the password to new password provided
      await user.updatePassword(newPassword);

      //Displays a snackbar that passowrd is updated successfully
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password updated successfully.'),
        ),
      );
    } on FirebaseAuthException catch (err) {
      print(err.code);

      //if there is an error message, stores the error message
      var message =
          'An error occurred, please check your credentials!';

      if (err.message != null) {
        message = err.message!;
      }

      //Displays the error message using a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } catch (err) {
      print(err);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.toString()),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }
}
