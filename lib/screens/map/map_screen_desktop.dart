import 'package:flutter/material.dart';
import 'package:travela/widgets/common/variable_map.dart';
import '../../common/api/locationController.dart';
import '../../widgets/common/top_navigation_bar.dart';

class MapScreenDesktop extends StatelessWidget {
  const MapScreenDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 80),
        child: const TopNavigationBar(
          hasSearch: false,
          hasAccount: true,
        ),
      ),
      body: Center(
        child: VariableMap(
          getCenter: LocationController.getCurrentLocation(),
        ),
      ),
    );
  }
}