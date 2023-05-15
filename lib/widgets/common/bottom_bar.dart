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
  static const double bottomBarHeight = 100;

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
            Image.asset(
              "lib/assets/logo_128.png",
              height: 45,
            ),
            SizedBox(width: 10),
            Text(
              "Travela",
              style: TextStyle(fontSize: 22),
            ),
            Container(
              color: Colors.grey,
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: 1,
              height: 60,
            ),
            Text("Follow"),
            SizedBox(width: 5),
            Tooltip(
              message: "imranZMiko",
              verticalOffset: 15,
              child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "lib/assets/github-mark/github-mark-64.png",
                  height: 55,
                ),
                splashRadius: 18,
              ),
            ),
            Tooltip(
              message: "NaimaHasan",
              verticalOffset: 15,
              child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "lib/assets/github-mark/github-mark-64.png",
                  height: 55,
                ),
                splashRadius: 18,
              ),
            ),
            Container(
              color: Colors.grey,
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: 1,
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text("© Travela"),
            ),
          ],
        ),
      ),
    );
  }
}
