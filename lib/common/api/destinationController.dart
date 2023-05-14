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

  static bool _containsNumericCharacters(String str) {
    return str.contains(RegExp(r'\d'));
  }

  static String? _getLocation(String address){
    List<String> parts = address.split(',');

    String firstNonNumericString = "worldwide";

    for (String part in parts) {
      if (!_containsNumericCharacters(part) && !part.contains("House")) {
        firstNonNumericString = part;
        break;
      }
    }
    return firstNonNumericString;
  }

  static Future<List<Destination>> getNearbyPlaces(double latitude, double longitude) async {
    List<Destination> allEntries = [];

    try {
      final queryParameters = {
        'latitude': '$latitude',
        'longitude': '$longitude',
      };

      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/nearbyDestinations/', queryParameters),
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

  static Future<Destination?> getDestination(String destinationName) async {
    Destination? result;

    try {
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/details/$destinationName/'),
      );

      var data = jsonDecode(response.body);

      result = Destination.fromJson(data);
    } catch (err) {
      print(err);
    }

    return result;
  }
}