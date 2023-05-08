import 'package:flutter/material.dart';
import 'package:travela/common/api/userController.dart';

import '../../../common/api/authenticationController.dart';
import '../../../common/models/user.dart';
import '../../edit_information/edit_information_screen.dart';

class AccountDashboard extends StatefulWidget {
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
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          left: screenSize.width * 0.03, right: screenSize.width * 0.03),
      child: FutureBuilder(
        future: _future,
        builder: (ctx, futureResult) {
          if (futureResult.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!futureResult.hasData) {
            return Text("Error retrieving user info.");
          }
          return Row(
            children: [
              SizedBox(
                width: screenSize.width * 0.09,
                height: screenSize.width * 0.09,
                child: futureResult.data!.userImageUrl == null
                    ? Icon(
                        Icons.account_circle,
                        size: screenSize.width * 0.09,
                      )
                    : ClipOval(
                        child: Image.network(
                            "http://127.0.0.1:8000${futureResult.data!.userImageUrl!}"),
                      ),
              ),
              Container(width: 35),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 10),
                  Text(
                    futureResult.data!.userName,
                    style: TextStyle(fontSize: screenSize.width * 0.018),
                  ),
                  Container(
                    height: screenSize.height * 0.03,
                  ),
                  SizedBox(
                    width: 130,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(EditInformationScreen.routeName);
                      },
                      child: Text(
                        'Edit Information',
                        style: TextStyle(fontSize: 12.5),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 15, right: 9),
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
