import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../widgets/common/auth_form_field.dart';

class EditInformationPassword extends StatefulWidget {
  EditInformationPassword({required this.data, Key? key}) : super(key: key);
  final String data;
  @override
  _EditInformationPasswordState createState() =>
      _EditInformationPasswordState();
}

class _EditInformationPasswordState extends State<EditInformationPassword> {
  final _formKey = GlobalKey<FormState>();

  var _userOldPassword = '';
  var _userNewPassword = '';
  var _userConfirmNewPassword = '';
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
    return Column(
      children: [
        SizedBox(
          width: 350,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Change Password?',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    color: icon == Icons.check ? Colors.green : Colors.black54,
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
                    iconSize: 16,
                    splashRadius: 12,
                  ),
                ),
              ),
            ],
          ),
        ),

        Visibility(
          visible: isEnabled,
          child: Column(
            children: [
              Container(
                height: 20,
              ),
              AuthFormField(
                text: 'Old Password',
                width: 350,
                validatorFn: (value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                  if (value != fieldData.text) {
                    return 'Passwords do not match!';
                  }
                  return null;
                },
                savedFn: (value) {},
                isObscurable: true,
              ),
              Container(
                height: 20,
              ),
              AuthFormField(
                text: 'New Password',
                width: 350,
                validatorFn: (value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                  if (value != fieldData.text) {
                    return 'Passwords do not match!';
                  }
                  return null;
                },
                savedFn: (value) {},
                isObscurable: true,
              ),
              Container(
                height: 20,
              ),
              AuthFormField(
                text: 'Confirm New Password',
                width: 350,
                validatorFn: (value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                  if (value != fieldData.text) {
                    return 'Passwords do not match!';
                  }
                  return null;
                },
                savedFn: (value) {},
                isObscurable: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
