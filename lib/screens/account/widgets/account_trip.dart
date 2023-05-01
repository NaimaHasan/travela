import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:travela/common/enums.dart';
import 'package:travela/screens/account/widgets/account_trip_grid.dart';
import 'package:travela/screens/account/widgets/account_trip_list.dart';
import 'package:travela/screens/new_trip/new_trip_screen.dart';

class AccountTrip extends StatelessWidget {
  const AccountTrip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var tabWidth = 950;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    top: 40,
                    bottom: MediaQuery.of(context).size.width < tabWidth ? 5 : 30),
                child: Text(
                  'Pending Trip requests',
                  style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.width < tabWidth ? 18 : 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            MediaQuery.of(context).size.width < tabWidth
                ? AccountTripList(group: TripGroup.pending)
                : AccountTripGrid(group: TripGroup.pending),
            Padding(
              padding: EdgeInsets.only(
                  top: 40,
                  bottom: MediaQuery.of(context).size.width < tabWidth ? 5 : 30),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your Trips',
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width < tabWidth ? 18 : 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(NewTripScreen.routeName);
                        },
                        icon: Icon(
                          Icons.add,
                          size: MediaQuery.of(context).size.width < tabWidth ? 22 : 30,
                        ),
                        splashRadius: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            MediaQuery.of(context).size.width < tabWidth
                ? AccountTripList(group: TripGroup.personal)
                : AccountTripGrid(group: TripGroup.personal),
            Padding(
              padding: EdgeInsets.only(
                  top: 40,
                  bottom: MediaQuery.of(context).size.width < tabWidth ? 5 : 30),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your Group Trips',
                      style: TextStyle(
                          fontSize:
                          MediaQuery.of(context).size.width < tabWidth ? 18 : 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(NewTripScreen.routeName);
                        },
                        icon: Icon(
                          Icons.add,
                          size: MediaQuery.of(context).size.width < tabWidth ? 22 : 30,
                        ),
                        splashRadius: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            MediaQuery.of(context).size.width < tabWidth
                ? AccountTripList(group: TripGroup.group)
                : AccountTripGrid(group: TripGroup.group),
          ],
        ),
      ),
    );
  }
}
