import 'package:flutter/material.dart';
import 'package:travela/common/api/location_controller.dart';
import 'package:travela/screens/new_trip/widgets/location_picker.dart';
import 'package:latlong2/latlong.dart';

//A stateful widget for the new trip form location
class NewTripLocation extends StatefulWidget {
  //Constructor
  const NewTripLocation({Key? key, required this.setLocation, required this.defaultLatLng, this.initialName, this.initialAddress}) : super(key: key);

  final LatLng defaultLatLng;
  final String? initialName;
  final String? initialAddress;
  final Function(LatLng value) setLocation;

  @override
  // ignore: library_private_types_in_public_api
  _NewTripLocationState createState() => _NewTripLocationState();
}

class _NewTripLocationState extends State<NewTripLocation> {
  TextEditingController locationController = TextEditingController();
  late Future<LatLng?> _future;
  // String defaultLocation = "";

  @override
  void initState() {
    print(widget.initialAddress);
    print(widget.initialName);
    locationController.text =
        formattedLatLng(widget.defaultLatLng); //set the initial value of text field
    if(widget.initialName != null){
      _future = LocationController.getDestinationLocation(widget.initialName!, widget.initialAddress!);
    }
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
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      width: 350,
      height: 60,
      child: Center(
        child: widget.initialName == null ? TextFormField(
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
                //Calls the LocationPicker widget
                return LocationPicker(
                  ctx: ctx,
                  initialPos: widget.defaultLatLng,
                );
              },
            );

            if(result != null){
              locationController.text = formattedLatLng(result);
              widget.setLocation(result);
            }
          },
        ) :
        //Future builder for new trip location
        //Checks the relevant conditions and displays messages on screen accordingly
        FutureBuilder(
          future: _future,
          builder: (ctx, futureResult){
              if(futureResult.connectionState == ConnectionState.waiting){
                return const CircularProgressIndicator();
              }
              if(!futureResult.hasData || futureResult.data == null){
                //Displays the text form field for the location picker
                return TextFormField(
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
                        //Calls the LocationPicker widget
                        return LocationPicker(
                          ctx: ctx,
                          initialPos: widget.defaultLatLng,
                        );
                      },
                    );
                    if(result != null){
                      locationController.text = formattedLatLng(result);
                      widget.setLocation(result);
                    }
                  },
                );
              }
              locationController.text = formattedLatLng(futureResult.data!);
              //Displays the text form field for the location picker
              return TextFormField(
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
                      //Calls the LocationPicker widget
                      return LocationPicker(
                        ctx: ctx,
                        initialPos: futureResult.data!,
                      );
                    },
                  );

                  if(result != null){
                    locationController.text = formattedLatLng(result);
                    widget.setLocation(result);
                  }
                },
              );
          },
        ),
      ),
    );
  }
}

//A function for formatting the longitude and latitude
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