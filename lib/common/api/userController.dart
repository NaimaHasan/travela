import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class UserController {
  static Future<List<TravelaUser>> getAllUsers() async {
    List<TravelaUser> allUsers = [];

    var response = await http.get(
      Uri.http('127.0.0.1:8000', 'users/'),
    );

    var data = jsonDecode(response.body);

    for (Map<String, dynamic> userEntry in data) {
      allUsers.add(TravelaUser.fromJson(userEntry));
    }
    return allUsers;
  }

  static Future<TravelaUser> getUser() async {
    TravelaUser currentUser;
    final auth = FirebaseAuth.instance;

    var response = await http.get(
      Uri.http('127.0.0.1:8000', 'users/${auth.currentUser!.email}/'),
    );

    var data = jsonDecode(response.body);


    currentUser = TravelaUser.fromJson(data);


    return currentUser;
  }

  static Future<void> setUserName(String name) async {
    final auth = FirebaseAuth.instance;

    try {
      Map<String, dynamic> body = {
        'userEmail': auth.currentUser!.email,
        'userName': name,
      };

      await http.put(
        Uri.http('127.0.0.1:8000', 'users/${auth.currentUser!.email}/'),
        headers: {
          'content-type': 'application/json'
        },
        body: jsonEncode(body),
      );
    } catch (err) {
      print(err);
    }
  }
}
