import 'package:flutter/material.dart';
import 'package:travela/screens/home/widgets/home_banner.dart';
import 'package:travela/screens/home/widgets/home_carousel.dart';
import 'package:travela/widgets/common/pill_button.dart';
import 'package:travela/widgets/common/spacing.dart';
import 'package:travela/widgets/common/top_navigation_bar.dart';

class HomeScreenDesktop extends StatelessWidget {
  const HomeScreenDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 80),
        child: const TopNavigationBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeBanner(),
            verticalSpaceSmall,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PillButton(
                  child: Text(
                    "Destinations",
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  onPress: (){},
                ),
                horizontalSpaceSmall,
                PillButton(
                  child: Text(
                    "Hotels",
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  onPress: (){},
                ),
                horizontalSpaceSmall,
                PillButton(
                  child: Text(
                    "Restaurants",
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  onPress: (){},
                ),
              ],
            ),
            verticalSpaceSmall,
            Align(
              child: Padding(
                padding: EdgeInsets.only(left: marginHorizontal),
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
              padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
              child: HomeCarousel(),
            ),
            verticalSpaceMedium,
            Align(
              child: Padding(
                padding: EdgeInsets.only(left: marginHorizontal),
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
              padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
              child: HomeCarousel(),
            ),
          ],
        ),
      ),
    );
  }
}
