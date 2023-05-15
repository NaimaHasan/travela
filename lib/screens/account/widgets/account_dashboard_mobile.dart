import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travela/common/api/user_controller.dart';

import '../../../common/api/authentication_controller.dart';
import '../../../common/models/user.dart';
import '../../edit_information/edit_information_screen.dart';

//A stateful widget for the top part of the account screen in mobile
//Top part contains the user name, user image, log out and edit information button
class AccountDashboardMobile extends StatefulWidget {
  //Constructor
  const AccountDashboardMobile({Key? key}) : super(key: key);

  @override
  State<AccountDashboardMobile> createState() => _AccountDashboardMobileState();
}

class _AccountDashboardMobileState extends State<AccountDashboardMobile> {
  late Future<TravelaUser?> _future;

  @override
  void initState() {
    _future = UserController.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //A future builder for retrieving user data
    //A circular progress indicator is displayed while the data is being loaded
    return FutureBuilder(
      future: _future,
      builder: (ctx, futureResult) {
        if (futureResult.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!futureResult.hasData) {
          return const Text("Error retrieving user info.");
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 55),
              child: Row(
                children: [
                  //If user does not have an image displays the default icon else shows the user image
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: IconButton(
                      onPressed: () {},
                      icon: futureResult.data!.userImageUrl == null
                          ? const Icon(
                              Icons.account_circle,
                              size: 90,
                            )
                          : ClipOval(
                              child: CachedNetworkImage(
                                imageUrl:
                                    "http://127.0.0.1:8000${futureResult.data!.userImageUrl!}",
                              ),
                            ),
                    ),
                  ),
                  Container(width: 35),
                  //The log out button
                  //When pressed logs out and routes to the log in screen
                  //The routing is handled in the controller
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 5, top: 25, right: 5),
                          child: IconButton(
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Authentication.logout(
                                context,
                              );
                            },
                            icon: const Icon(
                              Icons.logout,
                              size: 28,
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
            //Text field to display the user name
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                futureResult.data!.userName,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            //The edit information button
            //When pressed routes to the edit information screen
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: SizedBox(
                width: 130,
                height: 35,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditInformationScreen.routeName);
                  },
                  child: const Text(
                    'Edit Information',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
