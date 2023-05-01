import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/trip.dart';
import 'package:http/http.dart' as http;

class TripController {
  static Future<List<Trip>> getAllTrips() async {
    List<Trip> allTrips = [];

    var response = await http.get(
      Uri.http('127.0.0.1:8000', 'users/lalala/trips/'),
    );

    var data = jsonDecode(response.body);

    try {
      for (Map<String, dynamic> tripEntry in data) {
        allTrips.add(Trip.fromJson(tripEntry));
      }
    } catch (err){
      print(err);
    }

    return allTrips;
  }

  static Future<List<Trip>> getPersonalTrips() async {
    List<Trip> allTrips = await getAllTrips();

    List<Trip> personalTrips = [];

    for(Trip trip in allTrips){
      if(trip.sharedUsers.isNotEmpty) {
        personalTrips.add(trip);
      }
    }

    return personalTrips;
  }

  static Future<List<Trip>> getGroupTrips() async {
    List<Trip> allTrips = await getAllTrips();

    List<Trip> groupTrips = [];

    for(Trip trip in allTrips){
      if(trip.sharedUsers.isEmpty) {
        groupTrips.add(trip);
      }
    }

    return groupTrips;
  }

  static Future<void> postTrip(Trip trip) async {
    await http.post(
      Uri.http('127.0.0.1:8000', 'users/lalala/trips/'),
      body: {
        'owner': trip.owner,
        'tripName': trip.tripName,
        'startDate' : trip.startDate,
        'endDate' : trip.endDate,
      },
    );
  }
}
