import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travela/screens/account/account_screen.dart';
import 'package:travela/screens/destination/destination_screen.dart';
import 'package:travela/screens/home/home_screen.dart';
import 'package:travela/screens/login/login_screen.dart';
import 'package:travela/screens/map/map_screen.dart';
import 'package:travela/screens/search/search_screen.dart';
import 'package:travela/widgets/common/search_box.dart';
import 'package:travela/widgets/common/spacing.dart';
import 'package:travela/widgets/common/top_navigation_bar_item.dart';

import '../../common/api/userController.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BottomBar extends StatelessWidget {
  static const double bottomBarHeight = 150;

  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      elevation: 20,
      child: Container(
        height: bottomBarHeight,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: Row(
          children: [
            MediaQuery.of(context).size.width < 600
                ? horizontalSpaceMarginMobile
                : horizontalSpaceMargin,
            Row(
              children: [
                Image.asset("lib/assets/travelalogo.png", height: 70,),
                Text(
                  "Travela",
                  style: TextStyle(
                    fontSize: 22
                  ),
                ),
                VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Text("Follow"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
