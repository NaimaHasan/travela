import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTripDate extends StatefulWidget {
  const NewTripDate({required this.title, Key? key, required this.onSaved, required this.myController, required this.otherController, this.initialDate}) : super(key: key);
  final String title;
  final Function(String?) onSaved;
  final String? initialDate;
  final TextEditingController myController;
  final TextEditingController otherController;

  @override
  // ignore: library_private_types_in_public_api
  _NewTripDateState createState() => _NewTripDateState();
}

class _NewTripDateState extends State<NewTripDate> {
  @override
  void initState() {
    widget.myController.text = widget.initialDate == null ? DateFormat('yyyy-MM-dd')
        .format(DateTime.now()) : widget.initialDate!; //set the initial value of text field
    super.initState();
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
        child: TextFormField(
          controller: widget.myController,
          decoration: InputDecoration(
            prefixIcon: const Padding(
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
              initialDate: DateTime.now(),
              firstDate: widget.title == 'Start Date' ? DateTime(2000).toLocal() : DateFormat('yyyy-MM-dd').parse(widget.otherController.text).toLocal(),
              lastDate: widget.title == 'Start Date' ? DateFormat('yyyy-MM-dd').parse(widget.otherController.text).toLocal() : DateTime(2101).toLocal(),

            );
            if (pickedDate != null) {
              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate.toLocal());
              setState(() {
                widget.myController.text = formattedDate;
              });
            }
          },
        ),
      ),
    );
  }
}
