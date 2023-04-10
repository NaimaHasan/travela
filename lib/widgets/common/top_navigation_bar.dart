import 'package:flutter/material.dart';
import 'package:travela/screens/destination/destination_screen.dart';
import 'package:travela/screens/home/home_screen.dart';
import 'package:travela/screens/trip/trip_screen.dart';
import 'package:travela/widgets/common/spacing.dart';
import 'package:travela/widgets/common/top_navigation_bar_item.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar(
      {Key? key, this.hasSearch = true, this.hasAccount = true})
      : super(key: key);

  final bool hasSearch;
  final bool hasAccount;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      child: Row(
        children: [
          horizontalSpaceMargin,
          TopNavigationBarItem(
            text: "Travela",
            size: 28,
            route: HomeScreen.routeName,
          ),
          Expanded(
            child: Container(),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TopNavigationBarItem(text: "Home", route: HomeScreen.routeName,),
              horizontalSpaceSmall,
              TopNavigationBarItem(text: "Near Me", route: DestinationScreen.routeName,),
              horizontalSpaceSmall,
              TopNavigationBarItem(text: "Trips", route: TripScreen.routeName,),
              horizontalSpaceSmall,
              Visibility(
                visible: hasSearch,
                child: SizedBox(
                width: 0.25 * screenSize.width,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),),
            ],
          ),
          SizedBox(
            width: marginHorizontal,
            child: Visibility(
              visible: hasAccount,
              child: Icon(Icons.account_circle, size: 30,),
            ),
          ),
        ],
      ),
    );
  }
}
