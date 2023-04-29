import 'package:flutter/material.dart';
import 'package:travela/screens/home/widgets/home_banner.dart';
import 'package:travela/screens/home/widgets/home_carousel.dart';
import 'package:travela/screens/home/widgets/home_carousel_mobile.dart';
import 'package:travela/widgets/common/pill_button.dart';
import 'package:travela/widgets/common/spacing.dart';
import 'package:travela/widgets/common/top_navigation_bar.dart';

class HomeScreenMobile extends StatelessWidget {
  const HomeScreenMobile({
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
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: 0.85 * screenSize.width,
              height: 35,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            verticalSpaceSmall,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PillButton(
                  child: Text(
                    "Destinations",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  onPress: () {},
                ),
                horizontalSpaceSmall,
                PillButton(
                  child: Text(
                    "Hotels",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  onPress: () {},
                ),
                horizontalSpaceSmall,
                PillButton(
                  child: Text(
                    "Restaurants",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  onPress: () {},
                ),
              ],
            ),
            verticalSpaceSmall,
            Align(
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Hot Destinations",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
            verticalSpaceSmall,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: HomeCarouselMobile(),
            ),
            verticalSpaceMedium,
            Align(
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Location of the Day: Venice",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
            verticalSpaceSmall,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: HomeCarouselMobile(),
            ),
          ],
        ),
      ),
    );
  }
}
