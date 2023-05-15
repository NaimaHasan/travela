import 'package:flutter/material.dart';
import 'package:travela/screens/home/widgets/home_destination_view_mobile.dart';
import 'package:travela/widgets/common/top_navigation_bar.dart';

import '../../widgets/common/bottom_bar.dart';
import '../../widgets/common/spacing.dart';

//A stateless widget for displaying home screen mobile
class HomeScreenMobile extends StatelessWidget {
  //Constructor
  const HomeScreenMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 80),
        //Calls TopNavigationBar widget
        child: const TopNavigationBar(
          hasSearch: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Calls HomeDestinationViewMobile widget
            const HomeDestinationViewMobile(),
            verticalSpaceMedium,
            //Calls BottomBar widget
            const BottomBar(),
          ],
        ),
      ),
    );
  }
}
