import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewTripDate extends StatefulWidget {
  NewTripDate({required this.title, Key? key, required this.onSaved}) : super(key: key);
  final String title;
  final Function(String?) onSaved;

  @override
  _NewTripDateState createState() => _NewTripDateState();
}

class _NewTripDateState extends State<NewTripDate> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    dateController.text = DateFormat('yyyy-MM-dd')
        .format(DateTime.now()); //set the initial value of text field
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
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
              setState(() {
                dateController.text = formattedDate;
              });
            }
          },
        ),
      ),
    );
  }
}
