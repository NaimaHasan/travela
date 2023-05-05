import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:travela/screens/account/widgets/account_dashboard_mobile.dart';
import 'package:travela/screens/account/widgets/account_trip.dart';

import '../../common/api/authenticationController.dart';
import '../../widgets/common/top_navigation_bar.dart';
import '../edit_information/edit_information_screen.dart';

class AccountScreenMobile extends StatelessWidget {
  const AccountScreenMobile({
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AccountDashboardMobile(),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width - 20,
                color: Colors.black45,
              ),
              AccountTrip(),
            ],
          ),
        ),
      ),
    );
  }
}
