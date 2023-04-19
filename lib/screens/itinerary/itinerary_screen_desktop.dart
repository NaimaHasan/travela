import 'package:flutter/material.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_column.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_header.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_item.dart';

import '../../widgets/common/pill_button.dart';
import '../../widgets/common/spacing.dart';
import '../../widgets/common/top_navigation_bar.dart';

class ItineraryScreenDesktop extends StatelessWidget {
  const ItineraryScreenDesktop({super.key});

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
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox.square(
                  dimension: 0.16 * screenSize.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      'lib/assets/mock_1.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                verticalSpaceSmall,
                Text(
                  "Madeira Trip",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "23rd March - 28th March",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                PillButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Share",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.share,
                        color: Colors.black,
                        size: 16,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(10),
                  onPress: (){},
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ItineraryColumn(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    'lib/assets/mock_1.jpg',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
