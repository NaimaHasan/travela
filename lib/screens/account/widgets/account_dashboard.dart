import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travela/common/api/user_controller.dart';

import '../../../common/api/authentication_controller.dart';
import '../../../common/models/user.dart';
import '../../edit_information/edit_information_screen.dart';

//A stateful widget for the top part of the account screen in desktop
//Top part contains the user name, user image, log out and edit information button
class AccountDashboard extends StatefulWidget {
  //Constructor
  const AccountDashboard({Key? key}) : super(key: key);

  @override
  State<AccountDashboard> createState() => _AccountDashboardState();
}

class _AccountDashboardState extends State<AccountDashboard> {
  late Future<TravelaUser?> _future;

  @override
  void initState() {
    _future = UserController.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //screen size variable
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          left: screenSize.width * 0.03, right: screenSize.width * 0.03),
      //A future builder for retrieving user data
      //A circular progress indicator is displayed while the data is being loaded
      child: FutureBuilder(
        future: _future,
        builder: (ctx, futureResult) {
          if (futureResult.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!futureResult.hasData) {
            return const Text("Error retrieving user info.");
          }
          return Row(
            children: [
              SizedBox(
                width: screenSize.width * 0.09,
                height: screenSize.width * 0.09,
                //If user does not have an image displays the default icon else shows the user image
                child: futureResult.data!.userImageUrl == null
                    ? Icon(
                        Icons.account_circle,
                        size: screenSize.width * 0.09,
                      )
                    : ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              "http://127.0.0.1:8000${futureResult.data!.userImageUrl!}",
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              //A container for padding
              Container(width: 35),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 10),
                  //Text field to display the user name
                  Text(
                    futureResult.data!.userName,
                    style: TextStyle(fontSize: screenSize.width * 0.018),
                  ),
                  Container(
                    height: screenSize.height * 0.03,
                  ),
                  //The edit information button
                  //When pressed routes to the edit information screen
                  SizedBox(
                    width: 130,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(EditInformationScreen.routeName);
                      },
                      child: const Text(
                        'Edit Information',
                        style: TextStyle(fontSize: 12.5),
                      ),
                    ),
                  ),
                ],
              ),
              //The log out button
              //When pressed logs out and routes to the log in screen
              //The routing is handled in the controller
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, right: 9),
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
                          size: 30,
                        ),
                        splashRadius: 25,
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
          );
        },
      ),
    );
  }
}
