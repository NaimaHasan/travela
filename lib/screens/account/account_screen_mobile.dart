import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:travela/screens/account/widgets/account_trip.dart';

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
              Padding(
                padding: EdgeInsets.only(left: 10, right: 55),
                child: Row(
                  children: [
                    SizedBox(
                      width: 90,
                      height: 90,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.account_circle,
                          size: 90,
                        ),
                      ),
                    ),
                    Container(width: 35),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 5, top: 25, right: 5),
                            child: IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: () {},
                              icon: const Icon(
                                Icons.logout,
                                size: 28,
                              ),
                            ),
                          ),
                          const Text(
                            'Log out',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: Text(
                  'John Doe',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, bottom: 20),
                child: SizedBox(
                  width: 130,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(EditInformationScreen.routeName);
                    },
                    child: Text(
                      'Edit Information',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
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
