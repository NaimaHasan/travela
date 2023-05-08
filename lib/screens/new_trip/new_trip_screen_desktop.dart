import 'package:flutter/material.dart';
import 'package:travela/screens/new_trip/widgets/new_trip_form.dart';

import 'widgets/location_picker.dart';
import '../../widgets/common/top_navigation_bar.dart';

class NewTripScreenDesktop extends StatelessWidget {
  const NewTripScreenDesktop({
    super.key, this.initialName,
  });
  
  final String? initialName;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 80),
        child: const TopNavigationBar(
          hasSearch: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 420,
            child: Card(
              elevation: 5,
              child: NewTripForm(initialName: initialName),
            ),
          ),
        ),
      ),
    );
  }
}
