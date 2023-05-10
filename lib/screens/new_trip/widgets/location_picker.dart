import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:travela/common/api/locationController.dart';
import 'package:travela/widgets/common/spacing.dart';

class LocationPicker extends StatefulWidget {
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
                Expanded(
                  child: Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WhiteText(text: "SELECT LOCATION", size: 10),
                        verticalSpaceSmall,
                        WhiteText(text: "Latitude", size: 18),
                        WhiteText(
                            text: convertToDms(_marker.point.latitude, false),
                            size: 16),
                        verticalSpaceSmall,
                        WhiteText(text: "Longitude", size: 18),
                        WhiteText(
                            text: convertToDms(_marker.point.longitude, true),
                            size: 16),
                        verticalSpaceSmall,
                        TextField(
                          decoration: InputDecoration(
                            label: Text("Search",
                                style: TextStyle(color: Colors.white)),
                            focusColor: Colors.white,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          onSubmitted: (value) async {
                            final location =
                                await LocationController.getDestinationLocation(
                                    value);

                            if (location != null && value.isNotEmpty) {
                              _mapController.move(location, _mapController.zoom);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 496.0 - 150.0,
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
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: ElevatedButton(
                          onPressed: () async {
                            final p = _marker.point;
                            Navigator.pop(widget.ctx, p);
                          },
                          child: Text("OK"),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 80,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(widget.ctx),
                          child: Text("CANCEL"),
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

class WhiteText extends StatelessWidget {
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
