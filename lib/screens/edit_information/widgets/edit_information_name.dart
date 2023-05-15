import 'package:flutter/material.dart';
import 'package:travela/common/api/user_controller.dart';

//A stateless widget for edit information name
class EditInformationName extends StatefulWidget {
  //Constructor
  const EditInformationName({required this.data, Key? key}) : super(key: key);
  final String data;
  @override
  // ignore: library_private_types_in_public_api
  _EditInformationNameState createState() => _EditInformationNameState();
}

class _EditInformationNameState extends State<EditInformationName> {
  bool isEnabled = false;
  bool isLoading = false;
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
          borderRadius: const BorderRadius.all(Radius.circular(6))),
      width: 350,
      height: 80,
      child: Column(
        children: [
          const SizedBox(height: 5),
          SizedBox(
            height: 25,
            width: 350,
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                //if the edit icon is pressed it is replaced with a tick icon and the text field is activated
                //After user edits the name and presses the tick icon the new user name is set
                //A circular progress indicator is displayed in place of the tick/edit icon till the user name is set
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      color:
                          icon == Icons.check ? Colors.green : Colors.black54,
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      onPressed: isLoading == false
                          ? () async {
                              if (icon == Icons.check) {
                                setState(() {
                                  isLoading = true;
                                });
                                await UserController.setUserName(
                                    fieldData.text);
                                setState(() {
                                  isLoading = false;
                                });
                              }
                              setState(
                                () {
                                  isEnabled = !isEnabled;
                                  if (icon == Icons.edit) {
                                    icon = Icons.check;
                                  } else {
                                    icon = Icons.edit;
                                  }
                                },
                              );
                            }
                          : null,
                      icon: isLoading == false
                          ? Icon(icon)
                          : const SizedBox(
                              height: 16,
                              width: 16,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
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
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              ),
            ),
          ),
          const SizedBox(height: 4),
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
