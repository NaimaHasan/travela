import 'dart:convert';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class UserController {
  static Future<List<User>> getAllUsers() async {
    List<User> allUsers = [];

    var response = await http.get(
      Uri.http('127.0.0.1:8000', 'users/'),
    );

    var data = jsonDecode(response.body);

    for (Map<String, dynamic> userEntry in data) {
      allUsers.add(User.fromJson(userEntry));
    }

    // allUsers.forEach((element) {print(element);});

    return allUsers;
  }

}
