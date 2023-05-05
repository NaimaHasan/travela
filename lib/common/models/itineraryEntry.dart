import 'package:latlong2/latlong.dart';

class ItineraryEntry {
  const ItineraryEntry(
      {required this.trip,
        required this.dateTime,
        required this.description,
      required this.location});

  ItineraryEntry.fromJson(Map<String, dynamic> json)
      : trip = json['trip'],
        dateTime = DateTime.parse(json['dateTime']),
        description = json['description'],
        location = LatLng(double.parse(json['location_latitude']), double.parse(json['location_longitude']));

  final int trip;
  final DateTime dateTime;
  final String description;
  final LatLng location;

  @override
  String toString() {
    return "$trip $dateTime \"$description\" $location";
  }
}
