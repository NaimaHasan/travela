import 'package:flutter/material.dart';
import 'package:travela/screens/home/widgets/home_destination_view_mobile.dart';
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
      body: const SingleChildScrollView(
        child: HomeDestinationViewMobile(),
      ),
    );
  }
}
