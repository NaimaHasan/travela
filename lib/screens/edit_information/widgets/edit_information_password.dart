import 'package:flutter/material.dart';

import '../../../common/api/authentication_controller.dart';
import '../../../widgets/common/auth_form_field.dart';

//A stateless widget for changing password in edit information screen
class EditInformationPassword extends StatefulWidget {
  //Constructor
  const EditInformationPassword({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _EditInformationPasswordState createState() =>
      _EditInformationPasswordState();
}

class _EditInformationPasswordState extends State<EditInformationPassword> {
  final _formKey = GlobalKey<FormState>();
  var _userOldPassword = '';
  var _userNewPassword = '';
  // ignore: unused_field
  var _userConfirmNewPassword = '';
  // ignore: prefer_typing_uninitialized_variables
  var _invalidText;
  bool isEnabled = false;
  bool isLoading = false;
  IconData icon = Icons.edit;
  TextEditingController fieldData = TextEditingController();

  @override
  void initState() {
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
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Change Password?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              //if the edit icon is pressed it is replaced with a tick icon and the 3 text fields appear
              //The edit icon is replaced with a tick icon and isLoading is set to true
              //After user edits the name and presses the tick icon the new password is set
              //A circular progress indicator is displayed in place of the tick/edit icon till the password is set
              //After the password is set isLoading is set to false
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    color: icon == Icons.check ? Colors.green : Colors.black54,
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    onPressed: isLoading == false
                        ? () async {
                            if (icon == Icons.check) {
                              setState(() {
                                isLoading = true;
                              });
                              final isValid = _formKey.currentState!.validate();
                              FocusScope.of(context).unfocus();

                              if (isValid) {
                                _formKey.currentState!.save();

                                await Authentication.changePassword(context,
                                    _userOldPassword, _userNewPassword);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(_invalidText),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.error,
                                  ),
                                );
                              }
                              setState(() {
                                isLoading = false;
                              });
                              fieldData.text = "";
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
                        : const Center(
                            child: SizedBox(
                              height: 16,
                              width: 16,
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
        //if change password is enabled 3 text fields namely old password, new password and confirm new password ase visible
        //Re-authentication and respective message are displayed on the screen
        Visibility(
          visible: isEnabled,
          child: Form(
            key: _formKey,
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
                      _invalidText = 'Password is too short!';
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  savedFn: (value) {
                    _userOldPassword = value!;
                  },
                  isObscurable: true,
                ),
                Container(
                  height: 20,
                ),
                AuthFormField(
                  text: 'New Password',
                  controller: fieldData,
                  width: 350,
                  validatorFn: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      _invalidText = 'Password is too short!';
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  savedFn: (value) {
                    _userNewPassword = value!;
                  },
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
                      _invalidText = 'Password is too short!';
                      return 'Password is too short!';
                    }
                    if (value != fieldData.text) {
                      _invalidText = 'Passwords do not match!';
                      return 'Passwords do not match!';
                    }
                    return null;
                  },
                  savedFn: (value) {
                    _userConfirmNewPassword = value!;
                  },
                  isObscurable: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
