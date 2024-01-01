import 'package:flutter/material.dart';

import '../../../common/api/user_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

//A stateless widget for itinerary account circles for displaying pending users, shared users and owner in itinerary screen
class ItineraryAccountCircle extends StatelessWidget {
  //Constructor
  const ItineraryAccountCircle({Key? key, required this.email})
      : super(key: key);
  final String email;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25,
      height: 25,
      child: Center(
        //Future builder for account circle data
        //Checks the relevant conditions and displays messages on screen accordingly
        child: FutureBuilder(
          future: UserController.getUserFromEmail(email),
          builder: (ctx, futureResult) {
            if (futureResult.connectionState == ConnectionState.waiting) {
              return Container();
            }
            return Tooltip(
              message: futureResult.data!.userName,
              verticalOffset: 15,
              child: (futureResult.data!.userImageUrl == null)
                  ? const Icon(
                      Icons.account_circle,
                      size: 30,
                    )
                  : ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                            "http://127.0.0.1:8000${futureResult.data!.userImageUrl!}",
                        width: 25,
                        height: 25,
                        fit: BoxFit.cover,
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
