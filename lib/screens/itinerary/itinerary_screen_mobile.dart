import 'package:flutter/material.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_column.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_header.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_item.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_top_mobile.dart';

import '../../widgets/common/pill_button.dart';
import '../../widgets/common/spacing.dart';
import '../../widgets/common/top_navigation_bar.dart';

class ItineraryScreenMobile extends StatelessWidget {
  const ItineraryScreenMobile({super.key});

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
            ItineraryTopMobile(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ItineraryColumn(),
            ),
          ],
        ),
      ),
    );
  }
}
