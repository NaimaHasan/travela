import 'dart:convert';

import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'dart:html';
import 'package:http/http.dart' as http;

class LocationController {
  static Future<LatLng?> getCurrentLocation() async {
    LatLng? result;

    try {
      final position = await window.navigator.geolocation.getCurrentPosition();

      final latitude = position.coords?.latitude?.toDouble();
      final longitude = position.coords?.longitude?.toDouble();

      if (latitude == null || longitude == null) {
        return null;
      }
      result = LatLng(latitude, longitude);
    } catch (err) {
      print(err);
      return null;
    }
    return result;
  }

  static Future<LatLng?> getDestinationLocation(String locationName) async {
    LatLng? result;

    try {
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/location/$locationName/'),
      );

      var data = jsonDecode(response.body);

      result = LatLng(
          double.parse(data['latitude']), double.parse(data['longitude']));
    } catch (err) {
      print(err);
    }

    return result;
  }

  static Future<List<Map<String, dynamic>>> getNearbyLocations(double latitude, double longitude) async {
    List<Map<String, dynamic>> result = [];

      final queryParameters = {
        'latitude': '$latitude',
        'longitude': '$longitude',
      };

      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/nearby/', queryParameters),
      );

      var data = jsonDecode(response.body);

      print(data);

      for(var entry in data){
        result.add({
          "name": entry["name"],
          "location": LatLng(
            double.parse(entry['latitude']),
            double.parse(entry['longitude']),
          ),
        });
      }

    return result;
  }
}
