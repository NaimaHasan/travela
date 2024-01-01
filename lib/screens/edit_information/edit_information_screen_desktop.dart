import 'package:flutter/material.dart';
import 'package:travela/screens/edit_information/widgets/edit_information_fields.dart';

import '../../widgets/common/top_navigation_bar.dart';
import '../account/account_screen.dart';

//A stateless widget for edit information screen desktop
class EditInformationScreenDesktop extends StatelessWidget {
  //Constructor
  const EditInformationScreenDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 80),
        //Calls the top navigation bar widget
        child: const TopNavigationBar(
          hasSearch: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 420,
            child: Card(
              elevation: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 30,
                  ),
                  const Text(
                    'Edit Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  //Calls the EditInformationFields widget
                  const EditInformationFields(),
                  Container(
                    height: 60,
                  ),
                  //Elevated button that displays "Done"
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AccountScreen.routeName);
                      },
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
      ),
    );
  }
}
