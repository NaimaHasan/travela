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
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(6))),
      width: 350,
      height: 80,
      child: Column(
        children: [
          SizedBox(
            height: 25,
            width: 350,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      color:
                          icon == Icons.check ? Colors.green : Colors.black54,
                      onPressed: () {
                        setState(
                          () {
                            isEnabled = !isEnabled;
                            if (icon == Icons.edit_outlined)
                              icon = Icons.check;
                            else {
                              icon = Icons.edit;
                            }
                          },
                        );
                      },
                      icon: Icon(icon),
                      iconSize: 18,
                      splashRadius: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
            width: 350,
            child: TextFormField(
              controller: fieldData,
              enabled: isEnabled,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
