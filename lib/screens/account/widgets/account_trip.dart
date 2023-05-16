import 'package:flutter/material.dart';
import 'package:travela/common/enums.dart';
import 'package:travela/screens/account/widgets/account_trip_grid.dart';
import 'package:travela/screens/account/widgets/account_trip_list.dart';

import '../../../common/api/trip_controller.dart';
import '../../../common/models/trip.dart';

//A stateless widget to display the trips in the account screen
//Calls the classes AccountTripList for phone and tablet versions and AccountTripGrid for website version
class AccountTrip extends StatefulWidget {
  const AccountTrip({Key? key}) : super(key: key);

  @override
  State<AccountTrip> createState() => _AccountTripState();
}

class _AccountTripState extends State<AccountTrip> {
  late Future<List<Trip>> pendingFuture;
  late Future<List<Trip>> personalFuture;
  late Future<List<Trip>> groupFuture;

  void setFutures() {
    setState(() {
      pendingFuture = TripController.getPendingTrips();
      personalFuture = TripController.getPersonalTrips();
      groupFuture = TripController.getGroupTrips();
    });
  }

  @override
  void initState() {
    pendingFuture = TripController.getPendingTrips();
    personalFuture = TripController.getPersonalTrips();
    groupFuture = TripController.getGroupTrips();
    super.initState();
  }



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
                ? AccountTripList(
                    group: TripGroup.pending,
                    name: 'Pending Trip requests',
                    future: pendingFuture,
                    setFutures: setFutures)
                : AccountTripGrid(
                    group: TripGroup.pending,
                    name: 'Pending Trip requests',
                    future: pendingFuture,
                    setFutures: setFutures),
            //User trip list / grid respectively
            MediaQuery.of(context).size.width < tabWidth
                ? AccountTripList(
                    group: TripGroup.personal,
                    name: 'Your Trips',
                    future: personalFuture,
                    setFutures: setFutures)
                : AccountTripGrid(
                    group: TripGroup.personal,
                    name: 'Your Trips',
                    future: personalFuture,
                    setFutures: setFutures),
            //User group trip list / grid respectively
            MediaQuery.of(context).size.width < tabWidth
                ? AccountTripList(
                    group: TripGroup.group,
                    name: 'Your Group Trips',
                    future: groupFuture,
                    setFutures: setFutures)
                : AccountTripGrid(
                    group: TripGroup.group,
                    name: 'Your Group Trips',
                    future: groupFuture,
                    setFutures: setFutures),
          ],
        ),
      ),
    );
  }
}
