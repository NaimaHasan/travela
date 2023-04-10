import 'package:flutter/material.dart';
import 'package:travela/screens/edit_information/widgets/edit_information_name.dart';
import 'package:travela/screens/edit_information/widgets/edit_information_password.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../widgets/common/top_navigation_bar.dart';

class EditInformationScreenDesktop extends StatelessWidget {
  const EditInformationScreenDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 80),
        child: const TopNavigationBar(
          hasSearch: false,
          hasAccount: false,
        ),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height - 120,
          width: 420,
          child: Card(
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Edit Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Container(
                  height: 30,
                ),
                EditInformationName(title: 'Name', data: 'John Doe'),
                Container(
                  height: 30,
                ),
                EditInformationPassword(title: 'Password', data: '********'),
                const Padding(
                  padding: EdgeInsets.only(left: 35, top: 30, bottom: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Image',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(6),
                  color: Colors.black38,
                  dashPattern: [8, 4],
                  strokeWidth: 0.5,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6),
                    ),
                    child: Container(
                      height: 300,
                      width: 340,
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add_photo_alternate_outlined),
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                ),
                SizedBox(
                  width: 250,
                  height: 50,
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
