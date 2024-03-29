import 'package:latlong2/latlong.dart';

//Model class for itinerary entry
class ItineraryEntry {
  //Constructor
  const ItineraryEntry(
      { required this.id,
        required this.trip,
        required this.dateTime,
        required this.description,
      required this.location});

  ItineraryEntry.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        trip = json['trip'],
        dateTime = DateTime.parse(json['dateTime']),
        description = json['description'],
        location = LatLng(double.parse(json['location_latitude']), double.parse(json['location_longitude']));

  //Fields of the model
  final int id;
  final int trip;
  final DateTime dateTime;
  final String description;
  final LatLng location;

  @override
  String toString() {
    return "$trip $dateTime \"$description\" $location";
  }
}
