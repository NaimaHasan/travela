import 'package:flutter/material.dart';
import 'package:travela/common/api/userController.dart';

import '../../../common/api/authenticationController.dart';
import '../../edit_information/edit_information_screen.dart';

class AccountDashboardMobile extends StatelessWidget {
  const AccountDashboardMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserController.getUser(),
      builder: (ctx, futureResult) {
        if (futureResult.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!futureResult.hasData) {
          return Text("Error retrieving user info.");
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 55),
              child: Row(
                children: [
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: IconButton(
                      onPressed: () {},
                      icon: futureResult.data!.userImageUrl == null
                          ? Icon(
                              Icons.account_circle,
                              size: 90,
                            )
                          : ClipOval(
                              child: Image.network(
                                  "http://127.0.0.1:8000${futureResult.data!.userImageUrl!}"),
                            ),
                    ),
                  ),
                  Container(width: 35),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(bottom: 5, top: 25, right: 5),
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
            Padding(
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                futureResult.data!.userName,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 20),
              child: SizedBox(
                width: 130,
                height: 35,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditInformationScreen.routeName);
                  },
                  child: Text(
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
