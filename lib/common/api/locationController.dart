import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'dart:html';

class LocationController{
  static Future<LatLng?> getCurrentLocation() async {
    final position = await window.navigator.geolocation.getCurrentPosition();

    final latitude = position.coords?.latitude?.toDouble();
    final longitude = position.coords?.longitude?.toDouble();

    if(latitude == null || longitude == null) {
      return null;
    }

    LatLng result = LatLng(latitude, longitude);
    return result;
  }
}