import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:travela/common/api/location_controller.dart';

import '../../screens/destination/destination_screen.dart';

//A stateful widget for displaying map
class VariableMap extends StatefulWidget {
  //Constructor
  const VariableMap({Key? key, required this.getCenter}) : super(key: key);

  final Future<LatLng?> getCenter;

  @override
  State<VariableMap> createState() => VariableMapState();
}

class VariableMapState extends State<VariableMap> {
  LatLng _location = LatLng(51, 0);
  final List<Marker> _markers = [];
  final MapController _controller = MapController();

  @override
  void initState() {
    super.initState();
    widget.getCenter.then((value) {
      if (value != null) {
        setState(() {
          _location = value;
          _controller.move(_location, _controller.zoom);
        });
        //Gets the nearby places and displays it on the map with marker and name respectively
        LocationController.getNearbyLocations(value.latitude, value.longitude).then((value) {
          setState(() {
            _markers.clear();
            for (var pos in value) {
              _markers.add(
                Marker(
                  width: 35.0,
                  height: 35.0,
                  point: pos['location'],
                  builder: (ctx) => InkWell(
                    onTap: (){
                      Navigator.of(context)
                          .pushNamed("${DestinationScreen.routeName}/${pos['name']}");
                    },
                    child: Tooltip(
                      message: pos['name'],
                      padding: EdgeInsets.zero,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 35.0,
                      ),
                    ),
                  ),
                ),
              );
            }
            if (kDebugMode) {
              print(_markers);
            }
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //Displays thr map using flutter map
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
