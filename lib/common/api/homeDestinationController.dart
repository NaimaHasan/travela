
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/homeDestination.dart';

class HomeDestinationController {
  static Future<HomeDestination?> getHomeBanner() async {
    HomeDestination? result;

    try {
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/banner/'),
      );

      var data = jsonDecode(response.body);

      result = HomeDestination.fromJson(data);
      print(result);
    } catch (err) {
      print(err);
    }

    return result;
  }

  static Future<List<HomeDestination?>> getHomeHotDestinations() async {
    List<HomeDestination?> result = [];

    try {
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'destinations/hotDestinations/'),
      );

      var data = jsonDecode(response.body);
      for (Map<String, dynamic> homeDestination in data) {
        result.add(HomeDestination.fromJson(homeDestination));
      }
      print(result);
    } catch (err) {
      print(err);
    }

    return result;
  }
}
