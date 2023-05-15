
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/home_destination.dart';

class HomeDestinationController {
  //Function to get the home banner
  static Future<HomeDestination?> getHomeBanner() async {
    HomeDestination? result;

    try {
      //Gets the home banner from backend
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/banner/'),
      );

      //Stores the response body in data variable
      var data = jsonDecode(response.body);

      result = HomeDestination.fromJson(data);
      if (kDebugMode) {
        print(result);
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return result;
  }

  //Function to get the home hot destination
  static Future<List<HomeDestination?>> getHomeHotDestinations() async {
    List<HomeDestination?> result = [];

    try {
      //Gets the home hot destination from backend
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/hotDestinations/'),
      );

      //Stores the response body in data variable
      var data = jsonDecode(response.body);
      for (Map<String, dynamic> homeDestination in data) {
        result.add(HomeDestination.fromJson(homeDestination));
      }
      if (kDebugMode) {
        print(result);
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return result;
  }

  //Function to get the filtered home destination
  static Future<List<HomeDestination?>> getHomeDestinations() async {
    List<HomeDestination?> result = [];

    try {
      //Gets the filtered home destination from backend
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/homeFilter/Destination/'),
      );

      //Stores the response body in data variable
      var data = jsonDecode(response.body);
      for (Map<String, dynamic> homeDestination in data) {
        result.add(HomeDestination.fromJson(homeDestination));
      }
      if (kDebugMode) {
        print(result);
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return result;
  }

  //Function to get the filtered home hotels
  static Future<List<HomeDestination?>> getHomeHotels() async {
    List<HomeDestination?> result = [];

    try {
      //Gets the filtered home hotels from backend
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/homeFilter/Hotel/'),
      );

      //Stores the response body in data variable
      var data = jsonDecode(response.body);
      for (Map<String, dynamic> homeDestination in data) {
        result.add(HomeDestination.fromJson(homeDestination));
      }
      if (kDebugMode) {
        print(result);
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return result;
  }

  //Function to get the filtered home restaurants
  static Future<List<HomeDestination?>> getHomeRestaurants() async {
    List<HomeDestination?> result = [];

    try {
      //Gets the filtered home restaurants from backend
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/homeFilter/Restaurant/'),
      );

      //Stores the response body in data variable
      var data = jsonDecode(response.body);
      for (Map<String, dynamic> homeDestination in data) {
        result.add(HomeDestination.fromJson(homeDestination));
      }
      if (kDebugMode) {
        print(result);
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return result;
  }

  //Function to get the location of the day
  static Future<List<HomeDestination?>> getLocationOfTheDay() async {
    List<HomeDestination?> result = [];

    try {
      //Gets the location of the day from backend
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/homeLocationOfTheDay/'),
      );

      //Stores the response body in data variable
      var data = jsonDecode(response.body);
      for (Map<String, dynamic> homeDestination in data) {
        result.add(HomeDestination.fromJson(homeDestination));
      }
      if (kDebugMode) {
        print(result);
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return result;
  }

  //Function to get the destination filtered location of the day
  static Future<List<HomeDestination?>> getLocationOfTheDayDestinations() async {
    List<HomeDestination?> result = [];

    try {
      //Gets the destination filtered location of the day from backend
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/homeLocationOfTheDayFiltered/Destination/'),
      );

      //Stores the response body in data variable
      var data = jsonDecode(response.body);
      for (Map<String, dynamic> homeDestination in data) {
        result.add(HomeDestination.fromJson(homeDestination));
      }
      if (kDebugMode) {
        print(result);
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return result;
  }

  //Function to get the hotel filtered location of the day
  static Future<List<HomeDestination?>> getLocationOfTheDayHotels() async {
    List<HomeDestination?> result = [];

    try {
      //Gets the hotel filtered location of the day from backend
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/homeLocationOfTheDayFiltered/Hotel/'),
      );

      //Stores the response body in data variable
      var data = jsonDecode(response.body);
      for (Map<String, dynamic> homeDestination in data) {
        result.add(HomeDestination.fromJson(homeDestination));
      }
      if (kDebugMode) {
        print(result);
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return result;
  }

  //Function to get the restaurant filtered location of the day
  static Future<List<HomeDestination?>> getLocationOfTheDayRestaurants() async {
    List<HomeDestination?> result = [];

    try {
      //Gets the restaurant filtered location of the day from backend
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/homeLocationOfTheDayFiltered/Restaurant/'),
      );

      //Stores the response body in data variable
      var data = jsonDecode(response.body);
      for (Map<String, dynamic> homeDestination in data) {
        result.add(HomeDestination.fromJson(homeDestination));
      }
      if (kDebugMode) {
        print(result);
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return result;
  }
}
