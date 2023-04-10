import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditInformationName extends StatefulWidget {
  EditInformationName({required this.title, required this.data, Key? key})
      : super(key: key);
  final String title;
  final String data;
  @override
  _EditInformationNameState createState() => _EditInformationNameState();
}

class _EditInformationNameState extends State<EditInformationName> {
  bool isEnabled = false;
  IconData icon = Icons.edit;
  TextEditingController fieldData = TextEditingController();

  @override
  void initState() {
    fieldData.text = widget.data;
    super.initState();
  }

  @override
  void dispose() {
    fieldData.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldData,
      enabled: isEnabled,
      decoration: InputDecoration(
        labelText: widget.title,
        labelStyle: const TextStyle(
          fontSize: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        suffixIcon: IconButton(
          color: icon == Icons.check ? Colors.green : null,
          onPressed: () {
            setState(
              () {
                isEnabled = !isEnabled;
                if (icon == Icons.edit)
                  icon = Icons.check;
                else {
                  icon = Icons.edit;
                }
              },
            );
          },
          icon: Icon(icon),
          iconSize: 18,
          splashRadius: 18,
        ),
      ),
    );
  }
}
