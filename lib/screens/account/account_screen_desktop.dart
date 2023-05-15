import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:travela/screens/account/widgets/account_dashboard.dart';
import 'package:travela/screens/account/widgets/account_trip.dart';
import 'package:travela/widgets/common/bottom_bar.dart';
import 'package:travela/widgets/common/spacing.dart';

import '../../common/api/authenticationController.dart';
import '../../widgets/common/top_navigation_bar.dart';
import '../edit_information/edit_information_screen.dart';

class AccountScreenDesktop extends StatelessWidget {
  const AccountScreenDesktop({
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
          hasAccount: false,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints){
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: screenSize.width * 0.125,
                      right: screenSize.width * 0.125,
                      top: 30),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - BottomBar.bottomBarHeight - 70, // Set the desired minimum height
                    ),
                    child: Column(
                      children: [
                        AccountDashboard(),
                        Container(height: 20),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width * 0.75,
                          color: Colors.black45,
                        ),
                        AccountTrip(),
                      ],
                    ),
                  ),
                ),
                verticalSpaceMedium,
                BottomBar(),
              ],
            ),
          );
        },
      ),
    );
  }
}
