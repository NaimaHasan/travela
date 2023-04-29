import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:travela/screens/account/widgets/account_trip_grid.dart';
import 'package:travela/screens/account/widgets/account_trip_list.dart';
import 'package:travela/screens/new_trip/new_trip_screen.dart';

class AccountTrip extends StatelessWidget {
  const AccountTrip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Column(
          children: [
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 30),
                    child: Text(
                      'Pending Trip requests',
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width < 600 ? 18 : 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            MediaQuery.of(context).size.width < 600 ? AccountTripList() : AccountTripGrid(),
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 30),
                    child: Text(
                      'Your Trips',
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width < 600 ? 18 : 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 30),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(NewTripScreen.routeName);
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                        ),
                        splashRadius: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            MediaQuery.of(context).size.width < 600 ? AccountTripList() : AccountTripGrid(),
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 30),
                    child: Text(
                      'Your Group Trips',
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width < 600 ? 18 : 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 30),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(NewTripScreen.routeName);
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                        ),
                        splashRadius: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            MediaQuery.of(context).size.width < 600 ? AccountTripList() : AccountTripGrid(),
          ],
        ),
      ),
    );
  }
}
