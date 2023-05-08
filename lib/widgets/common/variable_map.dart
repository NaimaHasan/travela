import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:travela/common/api/locationController.dart';
import 'package:latlong2/latlong.dart';

class VariableMap extends StatefulWidget {
  const VariableMap({Key? key, required this.getCenter}) : super(key: key);

  final Future<LatLng?> getCenter;

  @override
  State<VariableMap> createState() => _VariableMapState();
}

class _VariableMapState extends State<VariableMap> {
  LatLng _location = LatLng(51, 0);
  MapController _controller = MapController();

  @override
  void initState() {
    super.initState();
    widget.getCenter.then((value){
      if(value != null){
        setState(() {
          _location = value;
          _controller.move(_location, _controller.zoom);
        });
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
          urlTemplate:
          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName:
          'dev.fleaflet.flutter_map.example',
        ),
      ],
    );
  }
}
