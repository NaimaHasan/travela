import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:travela/screens/account/widgets/account_trip.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: screenSize.width * 0.125,
              right: screenSize.width * 0.125,
              top: 30),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: screenSize.width * 0.03,
                    right: screenSize.width * 0.03),
                child: Row(
                  children: [
                    SizedBox(
                      width: screenSize.width * 0.09,
                      height: screenSize.width * 0.09,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.account_circle,
                          size: screenSize.width * 0.09,
                        ),
                      ),
                    ),
                    Container(width: 35),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 10),
                       Text(
                          'John Doe',
                          style: TextStyle(fontSize: screenSize.width * 0.018),
                        ),
                        Container(
                          height: screenSize.height * 0.03,
                        ),
                        SizedBox(
                          width: screenSize.width * 0.082,
                          height: 35,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(EditInformationScreen.routeName);
                            },
                            child: Text(
                              'Edit Information',
                              style: TextStyle(fontSize:  screenSize.width * 0.0075),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 15, right: 12),
                            child: IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: () {},
                              icon: const Icon(
                                Icons.logout,
                                size: 35,
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
    );
  }
}
