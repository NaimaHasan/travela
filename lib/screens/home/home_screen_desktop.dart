import 'package:flutter/material.dart';
import 'package:travela/screens/home/widgets/home_banner.dart';
import 'package:travela/screens/home/widgets/home_destination_view.dart';
import 'package:travela/widgets/common/bottom_bar.dart';
import 'package:travela/widgets/common/spacing.dart';
import 'package:travela/widgets/common/top_navigation_bar.dart';

class HomeScreenDesktop extends StatelessWidget {
  //Constructor
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
            const HomeBanner(),
            verticalSpaceSmall,
            const HomeDestinationView(),
            verticalSpaceMedium,
            const BottomBar(),
          ],
        ),
      ),
    );
  }
}
