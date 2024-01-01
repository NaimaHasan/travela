import 'package:flutter/foundation.dart';
import 'package:travela/common/models/destination.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class DestinationController{

  static Future<List<String>> checkAndRemoveImages(List<String> imageUrls) async {
    List<String> validImages = [];

    for (String url in imageUrls) {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        validImages.add(url);
      }
    }
    return validImages;
  }

  //Function for searching destinations
  static Future<List<Destination>> searchDestinations(String searchTerm) async {
    List<Destination> allEntries = [];

    try {
      //Gets response from django backend
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/search/$searchTerm/'),
      );

      //Stores the response body in data variable
      var data = jsonDecode(response.body);


      for (Map<String, dynamic> entry in data) {
        entry['image'] = await checkAndRemoveImages(List<String>.from(entry['image']));
        if(List<String>.from(entry['image']).isNotEmpty) {
          allEntries.add(Destination.fromJson(entry));
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return allEntries;
  }

  //Function to get nearby places
  static Future<List<Destination>> getNearbyPlaces(double latitude, double longitude) async {
    List<Destination> allEntries = [];

    try {
      //Storing the longitude and latitude of the location in queryParameters
      final queryParameters = {
        'latitude': '$latitude',
        'longitude': '$longitude',
      };

      //Gets the nearby places of the query location
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/nearbyDestinations/', queryParameters),
      );

      //Stores the response body in data variable
      var data = jsonDecode(response.body);


      for (Map<String, dynamic> entry in data) {
        entry['image'] = await checkAndRemoveImages(List<String>.from(entry['image']));
        if(List<String>.from(entry['image']).isNotEmpty) {
          allEntries.add(Destination.fromJson(entry));
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return allEntries;
  }

  //Function to get the details of a specific destination
  static Future<Destination?> getDestination(String destinationName) async {
    Destination? result;

    try {
      //Gets the destination detail from backend
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/details/$destinationName/'),
      );

      //Stores the response body in data variable
      var data = jsonDecode(response.body);
      data['image'] = await checkAndRemoveImages(List<String>.from(data['image']));
      if(List<String>.from(data['image']).isNotEmpty) {
        result = Destination.fromJson(data);
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return result;
  }
}