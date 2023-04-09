import 'package:flutter/material.dart';
import 'package:travela/widgets/common/spacing.dart';
import 'package:travela/widgets/common/top_navigation_bar_item.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({Key? key}) : super(key: key);

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
          ),
          Expanded(
            child: Container(),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TopNavigationBarItem(text: "Home"),
              horizontalSpaceSmall,
              TopNavigationBarItem(text: "Near Me"),
              horizontalSpaceSmall,
              TopNavigationBarItem(text: "Trips"),
              horizontalSpaceSmall,
              SizedBox(
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
              ),
            ],
          ),
          SizedBox(
            width: marginHorizontal,
            child: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}
