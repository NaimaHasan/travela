import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travela/common/api/tripController.dart';
import 'package:travela/common/models/trip.dart';
import 'package:travela/screens/account/account_screen.dart';
import 'package:travela/screens/new_trip/widgets/new_trip_name.dart';

import 'new_trip_date.dart';
import 'new_trip_location.dart';
import 'package:latlong2/latlong.dart';

class NewTripForm extends StatefulWidget {
  const NewTripForm({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(height: 30),
          const Text(
            'New Trip',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          NewTripName(
            onSaved: (value) {
              _name = value!;
            },
            label: "Name",
          ),
          NewTripDate(
            title: 'Start Date',
            onSaved: (value) {
              _startDate = value!;
            },
          ),
          NewTripDate(
            title: 'End Date',
            onSaved: (value) {
              _endDate = value!;
            },
          ),
          const Padding(
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
          NewTripLocation(
            defaultLatLng: _location,
            setLocation: (value) {
              _location = value;
            },
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
              ? DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(6),
            color: Colors.black38,
            dashPattern: [8, 4],
            strokeWidth: 0.5,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(6),
              ),
              child: Container(
                height: 300,
                width: 340,
                child: Center(
                  child: IconButton(
                    onPressed: () async {
                      _image = await ImagePicker().pickImage(source:ImageSource.gallery);
                      setState(() {});
                    },
                    icon: Icon(Icons.add_photo_alternate_outlined),
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          )
              : InkWell(
            onTap: () async {
              _image = await ImagePicker().pickImage(source:ImageSource.gallery);
              setState(() {});
            },
            child: Container(
              height: 340,
              width: 340,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: FutureBuilder(
                    future: _image!.readAsBytes(),
                    builder: (ctx, futureResult){
                      if(futureResult.connectionState == ConnectionState.waiting){
                        return Container();
                      }
                      if(!futureResult.hasData){
                        return Container();
                      }
                      return Image.memory(futureResult.data!);
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

                Navigator.of(context).pushNamed(AccountScreen.routeName);
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
