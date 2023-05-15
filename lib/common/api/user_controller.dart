import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class UserController {
  //Function to get all users
  static Future<List<TravelaUser>> getAllUsers() async {
    List<TravelaUser> allUsers = [];

    //Gets all users from the backend
    var response = await http.get(
      Uri.http('127.0.0.1:8000', 'users/'),
    );

    //Stores the response body in data variable
    var data = jsonDecode(response.body);

    for (Map<String, dynamic> userEntry in data) {
      allUsers.add(TravelaUser.fromJson(userEntry));
    }
    return allUsers;
  }

  //Function to get an individual user
  static Future<TravelaUser?> getUser() async {
    TravelaUser? currentUser;
    final auth = FirebaseAuth.instance;

    try {
      //Gets a single user from backend
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'users/${auth.currentUser!.email}/'),
      );

      //Stores the response body in data variable
      var data = jsonDecode(response.body);

      currentUser = TravelaUser.fromJson(data);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return currentUser;
  }

  //Function to get user from email
  static Future<TravelaUser?> getUserFromEmail(String email) async {
    TravelaUser? userData;

    try {
      //Gets user from backend given the backend
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'users/$email/'),
      );

      //Stores the response body in data variable
      var data = jsonDecode(response.body);

      userData = TravelaUser.fromJson(data);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return userData;
  }

  //Function to set user name
  static Future<void> setUserName(String name) async {
    final auth = FirebaseAuth.instance;

    try {
      Map<String, dynamic> body = {
        'userEmail': auth.currentUser!.email,
        'userName': name,
      };

      //Sets the user name in the backend
      await http.put(
        Uri.http('127.0.0.1:8000', 'users/${auth.currentUser!.email}/'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode(body),
      );
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  //Function to set user image
  static Future<void> setUserImage() async {
    final auth = FirebaseAuth.instance;

    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      var user = await getUser();

      //Sets the user image in the backend
      var uri = Uri.http('127.0.0.1:8000', 'users/${auth.currentUser!.email}/');
      var request = http.MultipartRequest('PUT', uri)
        ..fields['userEmail'] = auth.currentUser!.email!
        ..fields['userName'] = user!.userName
        ..files.add(http.MultipartFile.fromBytes(
            'userImage', await image!.readAsBytes(),
            contentType: MediaType('image', image.name.split(".")[1]),
            filename: image.name));
      await request.send();
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }
}
