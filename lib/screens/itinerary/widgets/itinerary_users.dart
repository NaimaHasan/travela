import 'package:flutter/material.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_account_circle.dart';


class ItineraryUsers extends StatelessWidget {
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
          child: Text(
            '$name users:',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        userList.isEmpty
            ? Text(
                'No ${name.toLowerCase()} users',
                style: const TextStyle(fontSize: 12),
              )
            : SizedBox(
                width: 0.16 * screenSize.width,
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  itemCount: userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItineraryAccountCircle(email: userList[index]);
                  },
                ),
              ),
      ],
    );
  }
}
