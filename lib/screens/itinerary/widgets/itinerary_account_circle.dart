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
      child: Center(
        //Future builder for account circle data
        //Checks the relevant conditions and displays messages on screen accordingly
        child: FutureBuilder(
          future: UserController.getUserFromEmail(email),
          builder: (ctx, futureResult) {
            if (futureResult.connectionState == ConnectionState.waiting) {
              return Container();
            }
            return InkWell(
              //Tool tip to display user name when hovered
              child: Tooltip(
                message: futureResult.data!.userName,
                verticalOffset: 15,
                child: Column(
                  //if there is no user image, then the default account circle is displayed
                  //else the account image is displayed
                  children: [
                    if (futureResult.data!.userImageUrl == null)
                      const Icon(
                        Icons.account_circle,
                        size: 30,
                      )
                    else
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              "http://127.0.0.1:8000${futureResult.data!.userImageUrl!}",
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
