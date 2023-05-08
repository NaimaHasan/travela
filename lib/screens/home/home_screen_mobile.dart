import 'package:flutter/material.dart';
import 'package:travela/screens/home/widgets/home_carousel_mobile.dart';
import 'package:travela/widgets/common/pill_button.dart';
import 'package:travela/widgets/common/search_box.dart';
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
            SearchBox(width: screenSize.width - 2 * marginHorizontalMobile),
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
            HomeCarouselMobile(name: 'Hot Destinations'),
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
            HomeCarouselMobile(name: 'Location of the day'),
          ],
        ),
      ),
    );
  }
}
