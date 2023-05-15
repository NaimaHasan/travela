import 'dart:convert';

import 'package:latlong2/latlong.dart';
import 'dart:html';
import 'package:http/http.dart' as http;

class LocationController {
  //Function to get the current location
  static Future<LatLng?> getCurrentLocation() async {
    LatLng? result;

    try {
      //Gets the longitude and latitude data from the user
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

  //Function to get the destination location
  static Future<LatLng?> getDestinationLocation(String locationName, String? locationAddress) async {
    LatLng? result;
    String searchTerm;

    if(locationAddress != null){
      searchTerm = "$locationName, $locationAddress";
    }
    else {
      searchTerm = locationName;
    }

    try {
      //Gets the destination location from the backend
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/location/$searchTerm/'),
      );

      //Stores the response body in data variable
      var data = jsonDecode(response.body);

      result = LatLng(
          double.parse(data['latitude']), double.parse(data['longitude']));
    } catch (err) {
      print(err);
    }

    return result;
  }

  //Function to get nearby locations
  static Future<List<Map<String, dynamic>>> getNearbyLocations(double latitude, double longitude) async {
    List<Map<String, dynamic>> result = [];

     //Storing the longitude and latitude of the location in queryParameters
      final queryParameters = {
        'latitude': '$latitude',
        'longitude': '$longitude',
      };

      //Gets the nearby places of the query location
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/nearby/', queryParameters),
      );

    //Stores the response body in data variable
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
