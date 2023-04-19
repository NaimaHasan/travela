import 'package:flutter/material.dart';
import 'package:travela/screens/destination/widgets/destination_image.dart';
import 'package:travela/screens/destination/widgets/destination_nearby.dart';

import '../../widgets/common/spacing.dart';
import '../../widgets/common/top_navigation_bar.dart';

class DestinationScreenDesktop extends StatelessWidget {
  const DestinationScreenDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    String loremIpsum =
        "Lorem ipsum dolor sit amet consectetur. Quis lectus sit vel sagittis. "
        "Ac fusce auctor orci laoreet sed. At nec id eget facilisi non quisque in mollis cursus. "
        "Tortor elit feugiat tempus interdum aliquam faucibus pellentesque. Ornare orci turpis sed "
        "viverra adipiscing tristique. Convallis nunc duis sollicitudin sit aliquam adipiscing lorem. "
        "Odio mi vulputate ipsum auctor consectetur sem viverra. Est viverra vivamus tellus justo tellus "
        "enim laoreet eleifend. Pellentesque in sem maecenas mauris mauris eget ipsum. Interdum dui adipiscing "
        "arcu enim id nec. Rutrum porttitor eu eget iaculis ac tempor euismod. Pellentesque sapien turpis lobortis "
        "enim pharetra lorem commodo nec. Non id aliquam sit gravida sed et mauris arcu. \nTellus non fames nibh quis "
        "tortor nunc habitant risus turpis. Feugiat magna sed lacinia rhoncus quam laoreet consequat. Nullam mattis gravida "
        "habitasse faucibus. Dolor malesuada augue mus in.";
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
            DestinationImage(),
            verticalSpaceMedium,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 0.5 * screenSize.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        verticalSpaceSmall,
                        Text(
                          loremIpsum,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        verticalSpaceMedium,
                        Text(
                          "Things to do",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        verticalSpaceSmall,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 7, right: 8),
                              child: CircleAvatar(
                                radius: 4,
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.black,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Lorem ipsum dolor sit amet consectetur. Est commodo senectus purus porttitor quisque non sem eu tempus."
                                " Ac ullamcorper sagittis cras non ornare ac neque. Blandit tincidunt diam",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 150),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Location",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Expanded(child: Container()),
                            Icon(Icons.location_on),
                          ],
                        ),
                        verticalSpaceSmall,
                        SizedBox(
                          height: 400,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            verticalSpaceMedium,
            Align(
              child: Padding(
                padding: EdgeInsets.only(left: marginHorizontal),
                child: Text(
                  "Nearby Places",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
              child: DestinationNearbyPlaces(),
            ),
          ],
        ),
      ),
    );
  }
}
