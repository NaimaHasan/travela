import 'package:flutter/material.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_account_circle.dart';

//A stateless widget to display the itinerary users that is the users that are participating on the trip
class ItineraryUsers extends StatelessWidget {
  //Constructor
  const ItineraryUsers({Key? key, required this.userList, required this.name})
      : super(key: key);
  final List<String> userList;
  final String name;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 15),
          //Displays the header telling what kind of users are displayed
          child: Text(
            '$name users:',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        //if there are no users displays No *type* users
        //else displays the users
        userList.isEmpty
            ? Text(
                'No ${name.toLowerCase()} users',
                style: const TextStyle(fontSize: 12),
              )
            : SizedBox(
                width: 0.16 * screenSize.width,
                height: 30,
                //Listview builder for displaying the users
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  itemCount: userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    //Calls the ItineraryAccountCircle widget for displaying the users
                    return ItineraryAccountCircle(email: userList[index]);
                  },
                ),
              ),
      ],
    );
  }
}
