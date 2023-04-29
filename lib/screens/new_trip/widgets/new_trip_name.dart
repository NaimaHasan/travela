import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewTripName extends StatefulWidget {
  NewTripName({Key? key, required this.onSaved}) : super(key: key);
  
  final Function(String?) onSaved;
  
  @override
  _NewTripNameState createState() => _NewTripNameState();
}

class _NewTripNameState extends State<NewTripName> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    dateController.text = "Default Name"; //set the initial value of text field
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
              labelText: "Name",
              border: InputBorder.none,
            ),
            onSaved: widget.onSaved,
          ),
        ),
      ),
    );
  }
}
