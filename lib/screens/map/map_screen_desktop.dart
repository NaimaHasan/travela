import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:travela/screens/login/widgets/login_form.dart';
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
        child: FlutterMap(
          options: MapOptions(),
          children: [
            TileLayer(
              urlTemplate:
              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName:
              'dev.fleaflet.flutter_map.example',
            ),
          ],
        ),
      ),
    );
  }
}
