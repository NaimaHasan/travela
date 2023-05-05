import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/itineraryEntry.dart';
import 'package:http/http.dart' as http;

class ItineraryController {
  static Future<List<ItineraryEntry>> getAllEntries(int tripID) async {
    List<ItineraryEntry> allEntries = [];

    try{
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'trips/$tripID/itineraryEntry/'),
      );

      var data = jsonDecode(response.body);

      for (Map<String, dynamic> entry in data) {
        allEntries.add(ItineraryEntry.fromJson(entry));
      }
    }
    catch(err){
      print(err);
    }

    return allEntries;
  }
}
