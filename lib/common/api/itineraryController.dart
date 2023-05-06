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

  static Future<void> editEntry(
      BuildContext context, ItineraryEntry entry) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return _NewDialog(
            ctx: ctx, tripID: entry.trip, isEditable: true, entry: entry);
      },
    );
  }
}

class _NewDialog extends StatefulWidget {
  const _NewDialog(
      {Key? key,
      required this.ctx,
      required this.tripID,
      this.isEditable = false,
      this.entry})
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
  late LatLng _location;

  String _description = "";
  String _startDate = "";
  DateTime? _startTime;

  @override
  void initState() {
    _location = widget.isEditable ? widget.entry!.location : LatLng(51, 0);
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
              _NameField(
                initalText: widget.isEditable
                    ? widget.entry!.description
                    : "Default Name",
                onSaved: (value) {
                  _description = value!;
                },
                label: "Description",
              ),
              _DateField(
                title: 'Date',
                initialTime:
                    widget.isEditable ? widget.entry!.dateTime : DateTime.now(),
                onSaved: (value) {
                  _startDate = value!;
                },
              ),
              _TimeField(
                initialTime:
                    widget.isEditable ? widget.entry!.dateTime : DateTime.now(),
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

                    var initialDate = DateTime.parse(_startDate);

                    initialDate = initialDate.add(Duration(
                      hours: _startTime!.hour,
                      minutes: _startTime!.minute,
                      seconds: _startTime!.second,
                    ));

                    if (!widget.isEditable) {
                      await http.post(
                        Uri.http('127.0.0.1:8000',
                            'trips/${widget.tripID}/itineraryEntry/'),
                        body: {
                          'trip': "${widget.tripID}",
                          'dateTime': initialDate.toIso8601String(),
                          'description': _description,
                          'location_latitude': _location.latitude.toStringAsFixed(20),
                          'location_longitude': _location.longitude.toStringAsFixed(20),
                        },
                      );
                    }

                    else{
                      print("hi");
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
      required this.initialTime})
      : super(key: key);
  final String title;
  final Function(String?) onSaved;
  final DateTime initialTime;

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
          onSaved: widget.onSaved,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: storedDateTime,
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
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
