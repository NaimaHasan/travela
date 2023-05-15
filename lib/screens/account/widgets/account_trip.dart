import 'package:flutter/material.dart';
import 'package:travela/common/enums.dart';
import 'package:travela/screens/account/widgets/account_trip_grid.dart';
import 'package:travela/screens/account/widgets/account_trip_list.dart';

//A stateless widget to display the trips in the account screen
//Calls the classes AccountTripList for phone and tablet versions and AccountTripGrid for website version
class AccountTrip extends StatelessWidget {
  //Constructor
  const AccountTrip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //Variable to specify the tablet width
    var tabWidth = 1150;
    //Wrapped in SingleChildScrollView to add scrolling
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Column(
          children: [
            //Pending trip request list / grid respectively
            MediaQuery.of(context).size.width < tabWidth
                ? const AccountTripList(group: TripGroup.pending, name: 'Pending Trip requests')
                : const AccountTripGrid(group: TripGroup.pending, name: 'Pending Trip requests'),
            //User trip list / grid respectively
            MediaQuery.of(context).size.width < tabWidth
                ? const AccountTripList(group: TripGroup.personal, name: 'Your Trips')
                : const AccountTripGrid(group: TripGroup.personal, name: 'Your Trips'),
            //User group trip list / grid respectively
            MediaQuery.of(context).size.width < tabWidth
                ? const AccountTripList(group: TripGroup.group, name: 'Your Group Trips')
                : const AccountTripGrid(group: TripGroup.group, name: 'Your Group Trips'),
          ],
        ),
      ),
    );
  }
}
