import 'package:flutter/material.dart';

import '../../../common/api/userController.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ItineraryAccountCircle extends StatelessWidget {
  const ItineraryAccountCircle({Key? key, required this.email})
      : super(key: key);
  final String email;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25,
      child: Center(
        child: FutureBuilder(
          future: UserController.getUserFromEmail(email),
          builder: (ctx, futureResult) {
            if (futureResult.connectionState == ConnectionState.waiting) {
              return Container();
            }
            return InkWell(
              child: Tooltip(
                message: futureResult.data!.userName,
                verticalOffset: 15,
                child: Column(
                  children: [
                    if (futureResult.data!.userImageUrl == null)
                      Icon(
                        Icons.account_circle,
                        size: 30,
                      )
                    else
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              "http://127.0.0.1:8000${futureResult.data!.userImageUrl!}",
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
