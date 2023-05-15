import 'package:flutter/material.dart';
import 'package:travela/screens/account/widgets/account_dashboard.dart';
import 'package:travela/screens/account/widgets/account_trip.dart';
import 'package:travela/widgets/common/bottom_bar.dart';
import 'package:travela/widgets/common/spacing.dart';


import '../../widgets/common/top_navigation_bar.dart';

//A stateless widget for account screen desktop
class AccountScreenDesktop extends StatelessWidget {
  //Constructor
  const AccountScreenDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //variable for screen size
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 80),
        //Calling the top navigation bar widget
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
                        //Calls the account dashboard widget
                        const AccountDashboard(),
                        Container(height: 20),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width * 0.75,
                          color: Colors.black45,
                        ),
                        //Calls the account trip widget
                        const AccountTrip(),
                      ],
                    ),
                  ),
                ),
                verticalSpaceMedium,
                //Calls the bottom bar widget
                const BottomBar(),
              ],
            ),
          );
        },
      ),
    );
  }
}
