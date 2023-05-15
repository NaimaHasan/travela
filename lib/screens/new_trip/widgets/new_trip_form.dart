import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travela/common/api/trip_controller.dart';
import 'package:travela/common/models/trip.dart';
import 'package:travela/screens/account/account_screen.dart';
import 'package:travela/screens/new_trip/widgets/new_trip_name.dart';

import 'new_trip_date.dart';
import 'new_trip_location.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

//A stateful widget for displaying the new trip form
//This widget has been also used for edit trip form
class NewTripForm extends StatefulWidget {
  //Constructor
  const NewTripForm(
      {Key? key, this.initialName, this.existingTrip, this.initialAddress})
      : super(key: key);

  final String? initialName;
  final String? initialAddress;
  final Trip? existingTrip;

  @override
  State<NewTripForm> createState() => _NewTripFormState();
}

class _NewTripFormState extends State<NewTripForm> {
  final _formKey = GlobalKey<FormState>();
  LatLng _location = LatLng(51, 0);

  String _name = "";
  String _startDate = "";
  String _endDate = "";

  XFile? _image;

  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();

  @override
  void dispose() {
    startController.dispose();
    endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(height: 30),
          Text(
            widget.existingTrip == null ? 'New Trip' : 'Edit Trip',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          //Calls the NewTripName widget
          NewTripName(
            onSaved: (value) {
              _name = value!;
            },
            label: "Name",
            initialName: widget.existingTrip == null
                ? widget.initialName
                : widget.existingTrip!.tripName,
          ),
          NewTripDate(
            title: 'Start Date',
            onSaved: (value) {
              _startDate = value!;
            },
            myController: startController,
            otherController: endController,
            initialDate: widget.existingTrip == null
                ? null
                : widget.existingTrip!.startDate,
          ),
          NewTripDate(
            title: 'End Date',
            onSaved: (value) {
              _endDate = value!;
            },
            myController: endController,
            otherController: startController,
            initialDate: widget.existingTrip == null
                ? null
                : widget.existingTrip!.endDate,
          ),
          Visibility(
            visible: widget.existingTrip == null,
            child: const Padding(
              padding: EdgeInsets.only(left: 30, top: 20, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Location',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.existingTrip == null,
            child: NewTripLocation(
              defaultLatLng: _location,
              setLocation: (value) {
                _location = value;
              },
              initialName: widget.initialName,
              initialAddress: widget.initialAddress,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30, top: 25, bottom: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Image',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          _image == null
              ? (widget.existingTrip == null ||
                      widget.existingTrip!.tripImageUrl == null
                  ? DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(6),
                      color: Colors.black38,
                      dashPattern: const [8, 4],
                      strokeWidth: 0.5,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                        child: SizedBox(
                          height: 300,
                          width: 340,
                          child: Center(
                            child: IconButton(
                              onPressed: () async {
                                _image = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                setState(() {});
                              },
                              icon: const Icon(
                                  Icons.add_photo_alternate_outlined),
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () async {
                        _image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        setState(() {});
                      },
                      child: SizedBox(
                        height: 340,
                        width: 340,
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "http://127.0.0.1:8000${widget.existingTrip!.tripImageUrl!}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ))
              : InkWell(
                  onTap: () async {
                    _image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    setState(() {});
                  },
                  child: SizedBox(
                    height: 340,
                    width: 340,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: FutureBuilder(
                          future: _image!.readAsBytes(),
                          builder: (ctx, futureResult) {
                            if (futureResult.connectionState ==
                                ConnectionState.waiting) {
                              return Container();
                            }
                            if (!futureResult.hasData) {
                              return Container();
                            }
                            return Image.memory(
                              futureResult.data!,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
          Container(
            height: 40,
          ),
          SizedBox(
            width: 250,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                _formKey.currentState!.save();
                final auth = FirebaseAuth.instance;

                if (widget.existingTrip == null) {
                  await TripController.postTrip(
                    Trip(
                      owner: "${auth.currentUser!.email}",
                      tripName: _name,
                      startDate: _startDate,
                      endDate: _endDate,
                    ),
                    _location,
                    _image,
                  );

                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamed(AccountScreen.routeName);
                } else {
                  if (_image != null) {
                    var uri = Uri.http('127.0.0.1:8000',
                        'trips/${widget.existingTrip!.tripID}/');
                    var request = http.MultipartRequest('PUT', uri)
                      ..fields['owner'] = widget.existingTrip!.owner
                      ..fields['tripName'] = _name
                      ..fields['startDate'] = _startDate
                      ..fields['endDate'] = _endDate
                      ..files.add(http.MultipartFile.fromBytes(
                          'tripImage', await _image!.readAsBytes(),
                          contentType:
                              MediaType('image', _image!.name.split(".")[1]),
                          filename: _image!.name));
                    await request.send();
                  } else {
                    await http.put(
                      Uri.http('127.0.0.1:8000',
                          'trips/${widget.existingTrip!.tripID}/'),
                      body: {
                        'owner': widget.existingTrip!.owner,
                        'tripName': _name,
                        'startDate': _startDate,
                        'endDate': _endDate,
                      },
                    );
                  }
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'Done',
                style: TextStyle(),
              ),
            ),
          ),
          Container(
            height: 30,
          ),
        ],
      ),
    );
  }
}
