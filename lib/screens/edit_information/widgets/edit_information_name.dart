import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travela/common/api/userController.dart';

class EditInformationName extends StatefulWidget {
  EditInformationName({required this.data, Key? key}) : super(key: key);
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
            height: 5,
          ),
          SizedBox(
            height: 25,
            width: 350,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Name',
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
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        setState(
                          () {
                            isEnabled = !isEnabled;
                            if (icon == Icons.edit) {
                              icon = Icons.check;
                            } else {
                              icon = Icons.edit;
                              UserController.setUserName(fieldData.text);
                            }
                          },
                        );
                      },
                      icon: Icon(icon),
                      iconSize: 16,
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
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              ),
            ),
          ),
          SizedBox(height: 4),
          Visibility(
            visible: isEnabled,
            child: Container(
              height: 1,
              width: 320,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
