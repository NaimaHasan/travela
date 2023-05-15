import 'package:flutter/material.dart';

class NewTripName extends StatefulWidget {
  //Constructor
  const NewTripName(
      {Key? key, required this.onSaved, required this.label, this.initialName})
      : super(key: key);

  final Function(String?) onSaved;
  final String label;
  final String? initialName;

  @override
  // ignore: library_private_types_in_public_api
  _NewTripNameState createState() => _NewTripNameState();
}

class _NewTripNameState extends State<NewTripName> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    dateController.text = widget.initialName == null
        ? "Default Name"
        : widget.initialName!; //set the initial value of text field
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
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      width: 350,
      height: 60,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
