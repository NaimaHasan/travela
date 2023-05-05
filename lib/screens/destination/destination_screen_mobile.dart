
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:travela/screens/destination/widgets/destination_image.dart';
import 'package:travela/screens/destination/widgets/destination_image_mobile.dart';
import 'package:travela/screens/destination/widgets/destination_nearby.dart';
import 'package:travela/screens/destination/widgets/destination_nearby_mobile.dart';

import '../../widgets/common/top_navigation_bar.dart';


class DestinationScreenMobile extends StatelessWidget {
  const DestinationScreenMobile({Key? key}) : super(key: key);

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DestinationImageMobile(),
            const Padding(
              padding:
              EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 30),
              child: Text(
                'Description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Lorem ipsum dolor sit amet consectetur. Quis lectus sit vel sagittis. "
                    "Ac fusce auctor orci laoreet sed. At nec id eget facilisi non quisque in mollis cursus. "
                    "Tortor elit feugiat tempus interdum aliquam faucibus pellentesque. Ornare orci turpis sed "
                    "viverra adipiscing tristique. Convallis nunc duis sollicitudin sit aliquam adipiscing lorem. "
                    "Odio mi vulputate ipsum auctor consectetur sem viverra. Est viverra vivamus tellus justo tellus "
                    "enim laoreet eleifend. Pellentesque in sem maecenas mauris mauris eget ipsum. Interdum dui adipiscing ",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, bottom: 15, top: 30),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Location',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.yellow[700],
                  )
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
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
            const Padding(
              padding:
              EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 30),
              child: Text(
                'Things to do',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'daoiholwfh awdbwak ldbqlwd awdsn;owa bfwoabfiwua lhfqiwsba ADHAWJD KBAWHIBD DABNAJKSBF JAKBFJA',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, bottom: 10, top: 40),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Nearby Places',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.maps_home_work_outlined,
                    color: Colors.yellow[700],
                  )
                ],
              ),
            ),
            const DestinationNearbyPlacesMobile(),
          ],
        ),
      ),
    );
  }
}