import 'package:flutter/material.dart';
import 'package:travela/widgets/common/variable_map.dart';
import '../../common/api/location_controller.dart';
import '../../widgets/common/top_navigation_bar.dart';

//A stateless widget displaying the map screen desktop
class MapScreenDesktop extends StatelessWidget {
  //Constructor
  const MapScreenDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 80),
        //Calls the TopNavigationBar widget
        child: const TopNavigationBar(
          hasSearch: false,
          hasAccount: true,
        ),
      ),
      body: Center(
        //Calls the VariableMap widget
        child: VariableMap(
          getCenter: LocationController.getCurrentLocation(),
        ),
      ),
    );
  }
}