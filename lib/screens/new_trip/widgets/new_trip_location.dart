import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travela/screens/new_trip/widgets/location_picker.dart';
import 'package:latlong2/latlong.dart';

class NewTripLocation extends StatefulWidget {
  NewTripLocation({Key? key, required this.setLocation, required this.defaultLatLng}) : super(key: key);

  final LatLng defaultLatLng;
  final Function(LatLng value) setLocation;

  @override
  _NewTripLocationState createState() => _NewTripLocationState();
}

class _NewTripLocationState extends State<NewTripLocation> {
  TextEditingController locationController = TextEditingController();
  // String defaultLocation = "";

  @override
  void initState() {
    locationController.text =
        formattedLatLng(widget.defaultLatLng); //set the initial value of text field
    super.initState();
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      width: 350,
      height: 60,
      child: Center(
        child: TextFormField(
          controller: locationController,
          decoration: const InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(Icons.map_outlined),
            ),
            border: InputBorder.none,
          ),
          readOnly: true,
          onTap: () async {
            var result = await showDialog(
              context: context,
              builder: (ctx) {
                return LocationPicker(
                  ctx: ctx,
                  initialPos: widget.defaultLatLng,
                );
              },
            );

            locationController.text = formattedLatLng(result);
            widget.setLocation(result);
          },
        ),
      ),
    );
  }
}

String formattedLatLng(LatLng input) {
  return "${convertToDms(input.latitude, false)} ${convertToDms(input.longitude, true)}";
}

String convertToDms(double dd, bool isLng) {
  var dir = dd < 0
      ? isLng ? 'W' : 'S'
      : isLng ? 'E' : 'N';

  var absDd = dd.abs();
  var deg = absDd.floor();
  var frac = absDd - deg;
  var min = (frac * 60).floor();
  var sec = frac * 3600 - min * 60;
  // Round it to 2 decimal points.
  sec = (sec * 100).round() / 100;
  return "$deg°$min\"$sec' $dir";
}