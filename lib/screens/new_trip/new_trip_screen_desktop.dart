import 'package:flutter/material.dart';
import 'package:travela/screens/new_trip/widgets/new_trip_form.dart';

import '../../widgets/common/top_navigation_bar.dart';

//A stateless widget for displaying the new trip screen desktop
class NewTripScreenDesktop extends StatelessWidget {
  //Constructor
  const NewTripScreenDesktop({
    super.key, this.initialName, this.initialAddress,
  });
  
  final String? initialName;
  final String? initialAddress;

  @override
  Widget build(BuildContext context) {
    //Variable for screen size
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 80),
        //Calls the TopNavigationBar widget
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
              //Calls the NewTripForm widget
              child: NewTripForm(initialName: initialName, initialAddress: initialAddress),
            ),
          ),
        ),
      ),
    );
  }
}
