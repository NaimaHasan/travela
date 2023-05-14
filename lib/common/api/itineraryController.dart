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

import '../models/trip.dart';

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

  static Future<void> newEntry(
      BuildContext context, int tripID, Trip trip) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return _NewDialog(
          ctx: ctx,
          tripID: tripID,
          startLimit: DateTime.parse(trip.startDate),
          endLimit: DateTime.parse(trip.endDate),
          trip: trip,
        );
      },
    );
  }

  static Future<void> editEntry(
      BuildContext context, ItineraryEntry entry, Trip trip) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return _NewDialog(
          ctx: ctx,
          tripID: entry.trip,
          isEditable: true,
          entry: entry,
          startLimit: DateTime.parse(trip.startDate),
          endLimit: DateTime.parse(trip.endDate),
          trip: trip,
        );
      },
    );
  }

  static Future<void> deleteEntry(
      BuildContext context, ItineraryEntry entry) async {
    try {
      await http.delete(
        Uri.http(
            '127.0.0.1:8000', 'trips/${entry.trip}/itineraryEntry/${entry.id}'),
      );
    } catch (err) {
      print(err);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Entry has been deleted'),
      ),
    );
  }

  static Future<LatLng> getFirstLocation(int tripID) async {
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

    return allEntries[0].location;
  }

  static Future<List<LatLng>> getAllLocations(int tripID) async {
    ItineraryEntry temp;
    List<LatLng> allLocations = [];

    try {
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'trips/$tripID/itineraryEntry/'),
      );

      var data = jsonDecode(response.body);

      for (Map<String, dynamic> entry in data) {
        temp = ItineraryEntry.fromJson(entry);
        allLocations.add(temp.location);
      }
    } catch (err) {
      print(err);
    }

    return allLocations;
  }
}

class _NewDialog extends StatefulWidget {
  const _NewDialog(
      {Key? key,
      required this.ctx,
      required this.tripID,
      this.isEditable = false,
      this.entry,
      required this.startLimit,
      required this.endLimit, required this.trip})
      : super(key: key);

  final BuildContext ctx;
  final int tripID;
  final bool isEditable;
  final ItineraryEntry? entry;

  final DateTime startLimit;
  final DateTime endLimit;

  final Trip trip;

  @override
  State<_NewDialog> createState() => _NewDialogState();
}

class _NewDialogState extends State<_NewDialog> {
  final _formKey = GlobalKey<FormState>();

  late LatLng _location;
  late String _description;
  late DateTime _startDate;
  late DateTime _startTime;

  @override
  void initState() {
    _location = widget.isEditable ? widget.entry!.location : LatLng(51, 0);
    _description =
        widget.isEditable ? widget.entry!.description : "Default Name";
    _startDate = widget.isEditable ? widget.entry!.dateTime : widget.startLimit;
    _startTime = widget.isEditable ? widget.entry!.dateTime : widget.startLimit;
    super.initState();
  }

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
              Text(
                widget.isEditable ? 'Edit Entry' : 'New Entry',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Visibility(
                visible: _description != "Start of Trip" &&
                    _description != "End of Trip",
                child: _NameField(
                  initalText: _description,
                  onSaved: (value) {
                    _description = value!;
                  },
                  label: "Description",
                ),
              ),
              _DateField(
                title: 'Date',
                initialTime: _startDate,
                onSaved: (value) {
                  _startDate = value;
                },
                startLimit: _description != "Start of Trip" &&
                    _description != "End of Trip" ? widget.startLimit : DateTime(2000),
                endLimit: _description != "Start of Trip" &&
                    _description != "End of Trip" ? widget.endLimit : DateTime(2101),
              ),
              _TimeField(
                initialTime: _startTime,
                onSaved: (value) {
                  _startTime = value;
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
                    var initialDate = _startDate;

                    initialDate = initialDate.copyWith(
                        hour: 0,
                        minute: 0,
                        second: 0,
                        microsecond: 0,
                        millisecond: 0);

                    initialDate = initialDate.add(Duration(
                      hours: _startTime.hour,
                      minutes: _startTime.minute,
                      seconds: _startTime.second,
                    ));

                    try {
                      if (!widget.isEditable) {
                        await http.post(
                          Uri.http('127.0.0.1:8000',
                              'trips/${widget.tripID}/itineraryEntry/'),
                          body: {
                            'trip': "${widget.tripID}",
                            'dateTime': initialDate.toIso8601String(),
                            'description': _description,
                            'location_latitude':
                                _location.latitude.toStringAsFixed(20),
                            'location_longitude':
                                _location.longitude.toStringAsFixed(20),
                          },
                        );
                      } else {
                        await http.put(
                          Uri.http('127.0.0.1:8000',
                              'trips/${widget.tripID}/itineraryEntry/${widget.entry!.id}/'),
                          body: {
                            'trip': "${widget.tripID}",
                            'dateTime': initialDate.toIso8601String(),
                            'description': _description,
                            'location_latitude':
                                _location.latitude.toStringAsFixed(20),
                            'location_longitude':
                                _location.longitude.toStringAsFixed(20),
                          },
                        );
                        if(_description == "Start of Trip"){
                          await http.put(
                            Uri.http('127.0.0.1:8000', 'trips/${widget.tripID}/'),
                            body: {
                              'owner': widget.trip.owner,
                              'tripName': widget.trip.tripName,
                              'startDate': DateFormat('yyyy-MM-dd').format(initialDate),
                              'endDate': widget.trip.endDate,
                            },
                          );
                        }
                        else if(_description == "End of Trip"){
                          await http.put(
                            Uri.http('127.0.0.1:8000', 'trips/${widget.tripID}/'),
                            body: {
                              'owner': widget.trip.owner,
                              'tripName': widget.trip.tripName,
                              'startDate': widget.trip.startDate,
                              'endDate': DateFormat('yyyy-MM-dd').format(initialDate),
                            },
                          );
                        }
                      }
                    } catch (err) {
                      print(err);
                    }

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

class _NameField extends StatefulWidget {
  const _NameField(
      {Key? key,
      required this.onSaved,
      required this.label,
      required this.initalText})
      : super(key: key);

  final Function(String?) onSaved;
  final String label;
  final String initalText;

  @override
  _NameFieldState createState() => _NameFieldState();
}

class _NameFieldState extends State<_NameField> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    dateController.text =
        widget.initalText; //set the initial value of text field
    super.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: TextFormField(
            controller: dateController,
            decoration: InputDecoration(
              labelText: widget.label,
              border: InputBorder.none,
            ),
            onSaved: widget.onSaved,
          ),
        ),
      ),
    );
  }
}

class _DateField extends StatefulWidget {
  const _DateField(
      {required this.title,
      Key? key,
      required this.onSaved,
      required this.initialTime, required this.startLimit, required this.endLimit})
      : super(key: key);
  final String title;
  final Function(DateTime) onSaved;
  final DateTime initialTime;

  final DateTime startLimit;
  final DateTime endLimit;

  @override
  _DateFieldState createState() => _DateFieldState();
}

class _DateFieldState extends State<_DateField> {
  TextEditingController dateController = TextEditingController();
  late DateTime storedDateTime;

  @override
  void initState() {
    dateController.text = DateFormat('yyyy-MM-dd')
        .format(widget.initialTime); //set the initial value of text field
    storedDateTime = widget.initialTime;
    super.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
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
          controller: dateController,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(Icons.calendar_today),
            ),
            labelText: widget.title,
            border: InputBorder.none,
          ),
          readOnly: true,
          onSaved: (value) {
            widget.onSaved(storedDateTime);
          },
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: storedDateTime,
              firstDate: widget.startLimit,
              lastDate: widget.endLimit,
            );
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              setState(() {
                dateController.text = formattedDate;
                storedDateTime = pickedDate;
              });
            }
          },
        ),
      ),
    );
  }
}

class _TimeField extends StatefulWidget {
  const _TimeField({Key? key, required this.onSaved, required this.initialTime})
      : super(key: key);
  final Function(DateTime) onSaved;
  final DateTime initialTime;

  @override
  _TimeFieldState createState() => _TimeFieldState();
}

class _TimeFieldState extends State<_TimeField> {
  TextEditingController timeController = TextEditingController();
  late DateTime storedDateTime;

  @override
  void initState() {
    timeController.text = DateFormat('h:mm a')
        .format(widget.initialTime); //set the initial value of text field
    storedDateTime = widget.initialTime;
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
