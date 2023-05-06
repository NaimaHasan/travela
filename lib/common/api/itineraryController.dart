import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travela/screens/new_trip/widgets/new_trip_form.dart';

import '../../screens/new_trip/widgets/new_trip_date.dart';
import '../../screens/new_trip/widgets/new_trip_location.dart';
import '../../screens/new_trip/widgets/new_trip_name.dart';
import '../models/itineraryEntry.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class ItineraryController {
  static Future<List<ItineraryEntry>> getAllEntries(int tripID) async {
    List<ItineraryEntry> allEntries = [];

    try {
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'trips/$tripID/itineraryEntry/'),
      );

      var data = jsonDecode(response.body);

      for (Map<String, dynamic> entry in data) {
        allEntries.add(ItineraryEntry.fromJson(entry));
      }

    } catch (err) {
      print(err);
    }

    return allEntries;
  }

  static Future<void> newEntry(BuildContext context, int tripID) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return _NewDialog(ctx: ctx, tripID: tripID);
      },
    );
  }
}

class _NewDialog extends StatefulWidget {
  const _NewDialog({Key? key, required this.ctx, required this.tripID, this.isEditable = false, this.entry})
      : super(key: key);

  final BuildContext ctx;
  final int tripID;
  final bool isEditable;
  final ItineraryEntry? entry;

  @override
  State<_NewDialog> createState() => _NewDialogState();
}

class _NewDialogState extends State<_NewDialog> {
  final _formKey = GlobalKey<FormState>();
  LatLng _location = LatLng(51, 0);

  String _description = "";
  String _startDate = "";
  DateTime? _startTime;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      children: [
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: 20),
              const Text(
                'New Entry',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              NewTripName(
                onSaved: (value) {
                  _description = value!;
                },
                label: "Description",
              ),
              NewTripDate(
                title: 'Date',
                onSaved: (value) {
                  _startDate = value!;
                },
              ),
              _TimeField(onSaved: (value) {
                _startTime = value;
              }),
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

                    var initialDate = DateTime.parse(_startDate);

                    initialDate = initialDate.add(Duration(
                      hours: _startTime!.hour,
                      minutes: _startTime!.minute,
                      seconds: _startTime!.second,
                    ));


                    await http.post(
                      Uri.http('127.0.0.1:8000', 'trips/${widget.tripID}/itineraryEntry/'),
                      body: {
                        'trip': "${widget.tripID}",
                        'dateTime': initialDate.toIso8601String(),
                        'description': _description,
                        'location_latitude': _location.latitude.toString(),
                        'location_longitude': _location.longitude.toString(),
                      },
                    );

                    Navigator.pop(widget.ctx);
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
        ),
      ],
    );
  }
}

class _TimeField extends StatefulWidget {
  const _TimeField({Key? key, required this.onSaved}) : super(key: key);
  final Function(DateTime) onSaved;

  @override
  _TimeFieldState createState() => _TimeFieldState();
}

class _TimeFieldState extends State<_TimeField> {
  TextEditingController timeController = TextEditingController();
  late DateTime storedDateTime;

  @override
  void initState() {
    timeController.text = DateFormat('h:mm a')
        .format(DateTime.now()); //set the initial value of text field
    storedDateTime = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      width: 350,
      height: 60,
      child: Center(
        child: TextFormField(
          controller: timeController,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(Icons.calendar_today),
            ),
            labelText: "Time",
            border: InputBorder.none,
          ),
          readOnly: true,
          onSaved: (value) {
            widget.onSaved(storedDateTime);
          },
          onTap: () async {
            TimeOfDay? selectedTime = await showTimePicker(
              initialTime: TimeOfDay(
                  hour: storedDateTime.hour, minute: storedDateTime.minute),
              context: context,
            );

            if (selectedTime != null) {
              var selectedDateTime = DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  selectedTime.hour,
                  selectedTime.minute);
              String formattedDate =
                  DateFormat('h:mm a').format(selectedDateTime);
              setState(() {
                timeController.text = formattedDate;
                storedDateTime = selectedDateTime;
              });
            }
          },
        ),
      ),
    );
  }
}
