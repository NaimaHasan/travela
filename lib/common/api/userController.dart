import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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

  static Future<TravelaUser?> getUser() async {
    TravelaUser? currentUser;
    final auth = FirebaseAuth.instance;

    try{
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'users/${auth.currentUser!.email}/'),
      );

      var data = jsonDecode(response.body);

      currentUser = TravelaUser.fromJson(data);
    }catch(err){
      print(err);
    }

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
        headers: {'content-type': 'application/json'},
        body: jsonEncode(body),
      );
    } catch (err) {
      print(err);
    }
  }

  static Future<void> setUserImage() async {
    final auth = FirebaseAuth.instance;

    try {
      final image = await ImagePicker().pickImage(source:ImageSource.gallery);
      var user = await getUser();

      var uri = Uri.http('127.0.0.1:8000', 'users/${auth.currentUser!.email}/');
      var request = http.MultipartRequest('PUT', uri)
        ..fields['userEmail'] = auth.currentUser!.email!
        ..fields['userName'] = user!.userName
        ..files.add(http.MultipartFile.fromBytes('userImage', await image!.readAsBytes(), contentType: MediaType('image', image.name.split(".")[1]), filename: image.name));
      var response = await request.send();

    } catch (err) {
      print(err);
    }
  }
}
