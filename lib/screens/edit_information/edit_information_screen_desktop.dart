import 'package:flutter/material.dart';
import 'package:travela/screens/edit_information/widgets/edit_information_name.dart';
import 'package:travela/screens/edit_information/widgets/edit_information_password.dart';

class EditInformationScreenDesktop extends StatelessWidget {
  const EditInformationScreenDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height - 120,
          width: 450,
          child: Card(
            elevation: 5,
            //color: Colors.black12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Edit Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Container(
                  height: 60,
                ),
                SizedBox(
                  width: 350,
                  child: EditInformationName(title: 'Name', data: 'John Doe'),
                ),
                Container(
                  height: 30,
                ),
                SizedBox(
                  width: 350,
                  child: EditInformationPassword(title: 'Password', data: '********')
                ),
                Container(
                  height: 60,
                ),
                SizedBox(
                  width: 300,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Done',
                      style: TextStyle(),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
