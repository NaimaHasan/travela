import 'package:travela/common/models/destination.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DestinationController{
  static Future<List<Destination>> searchDestinations(String searchTerm) async {
    List<Destination> allEntries = [];

    try {
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/search/$searchTerm/'),
      );

      var data = jsonDecode(response.body);

      for (Map<String, dynamic> entry in data) {
        allEntries.add(Destination.fromJson(entry));
      }
    } catch (err) {
      print(err);
    }

    return allEntries;
  }
}