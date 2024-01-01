import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:travela/common/api/location_controller.dart';
import 'package:travela/widgets/common/spacing.dart';

//A stateful widget for location picker
class LocationPicker extends StatefulWidget {
  //Constructor
  const LocationPicker({Key? key, required this.ctx, required this.initialPos})
      : super(key: key);

  final BuildContext ctx;
  final LatLng initialPos;

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  late Marker _marker;
  final MapController _mapController = MapController();

  @override
  void initState() {
    _marker = Marker(
      width: 150.0,
      height: 150.0,
      point: widget.initialPos,
      builder: (ctx) => const Icon(
        Icons.location_on,
        color: Colors.red,
        size: 35.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //A simple dialog is displayed when the location field in the trip form is tapped
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      children: [
        SizedBox(
          height: 346.0,
          width: 496.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Row(
              children: [
                SizedBox(
                  width: 150,
                  child: Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const WhiteText(text: "SELECT LOCATION", size: 10),
                        verticalSpaceSmall,
                        //Widgets for displaying the latitude of the location
                        const WhiteText(text: "Latitude", size: 18),
                        WhiteText(
                            text: convertToDms(_marker.point.latitude, false),
                            size: 16),
                        verticalSpaceSmall,
                        //Widgets for displaying the longitude of the location
                        const WhiteText(text: "Longitude", size: 18),
                        WhiteText(
                            text: convertToDms(_marker.point.longitude, true),
                            size: 16),
                        verticalSpaceSmall,
                        //Displaying the search field in the location picker
                        TextField(
                          decoration: const InputDecoration(
                            label: Text("Search",
                                style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            focusColor: Colors.white,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          onSubmitted: (value) async {
                            final location =
                                await LocationController.getDestinationLocation(
                                    value, null);

                            if (location != null && value.isNotEmpty) {
                              _mapController.move(location, _mapController.zoom);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                //Displaying the map in the location picker simple dialog
                Expanded(
                  child: Stack(
                    children: [
                      FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          onTap: (tapPos, latlng) {
                            setState(() {
                              _marker = Marker(
                                width: 150.0,
                                height: 150.0,
                                point: latlng,
                                builder: (ctx) => const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 35.0,
                                ),
                              );
                            });
                          },
                          center: widget.initialPos,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName:
                                'dev.fleaflet.flutter_map.example',
                          ),
                          MarkerLayer(
                            markers: [_marker],
                          )
                        ],
                      ),
                      //Displaying the buttons in the location picker simple dialog
                      Positioned(
                        bottom: 10,
                        right: 10,
                        //Displaying the elevated button with text "OK"
                        child: ElevatedButton(
                          onPressed: () async {
                            final p = _marker.point;
                            Navigator.pop(widget.ctx, p);
                          },
                          child: const Text("OK"),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 80,
                        //Displaying the elevated button with text "CANCEL"
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(widget.ctx),
                          child: const Text("CANCEL"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

//A stateless widget for the texts in the simple dialogue
class WhiteText extends StatelessWidget {
  //Constructor
  const WhiteText({Key? key, required this.text, this.size}) : super(key: key);

  final String text;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: Colors.white,
      ),
    );
  }
}

//A function to covert the location parameters
String convertToDms(double dd, bool isLng) {
  var dir = dd < 0
      ? isLng
          ? 'W'
          : 'S'
      : isLng
          ? 'E'
          : 'N';

  var absDd = dd.abs();
  var deg = absDd.floor();
  var frac = absDd - deg;
  var min = (frac * 60).floor();
  var sec = frac * 3600 - min * 60;
  // Round it to 2 decimal points.
  sec = (sec * 100).round() / 100;
  return "$deg°$min\"$sec' $dir";
}
