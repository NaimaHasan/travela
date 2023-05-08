import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:travela/common/api/locationController.dart';
import 'package:latlong2/latlong.dart';

class VariableMap extends StatefulWidget {
  const VariableMap({Key? key, required this.getCenter, this.getMarkers})
      : super(key: key);

  final Future<LatLng?> getCenter;
  final Future<List<LatLng>>? getMarkers;

  @override
  State<VariableMap> createState() => VariableMapState();
}

class VariableMapState extends State<VariableMap> {
  LatLng _location = LatLng(51, 0);
  List<Marker> _markers = [];
  MapController _controller = MapController();

  @override
  void initState() {
    super.initState();
    widget.getCenter.then((value) {
      if (value != null) {
        setState(() {
          _location = value;
          _controller.move(_location, _controller.zoom);
        });
        if (widget.getMarkers != null) {
          widget.getMarkers!.then((value) {
            setState(() {
              _markers.clear();
              for (var pos in value) {
                _markers.add(
                  Marker(
                    width: 150.0,
                    height: 150.0,
                    point: pos,
                    builder: (ctx) => const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 35.0,
                    ),
                  ),
                );
              }
              print(_markers);
            });
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _controller,
      options: MapOptions(
        center: _location,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        MarkerLayer(
          markers: _markers,
        )
      ],
    );
  }
}
