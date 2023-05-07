import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travela/screens/account/account_screen.dart';
import 'package:travela/screens/destination/destination_screen.dart';
import 'package:travela/screens/home/home_screen.dart';
import 'package:travela/screens/login/login_screen.dart';
import 'package:travela/screens/map/map_screen.dart';
import 'package:travela/widgets/common/spacing.dart';
import 'package:travela/widgets/common/top_navigation_bar_item.dart';

import '../../common/api/userController.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar(
      {Key? key, this.hasSearch = true, this.hasAccount = true})
      : super(key: key);

  final bool hasSearch;
  final bool hasAccount;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      child: Row(
        children: [
          MediaQuery.of(context).size.width < 600
              ? horizontalSpaceMarginMobile
              : horizontalSpaceMargin,
          TopNavigationBarItem(
            text: "Travela",
            size: 28,
            route: HomeScreen.routeName,
          ),
          Expanded(
            child: Container(),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TopNavigationBarItem(
                text: "Home",
                route: HomeScreen.routeName,
              ),
              MediaQuery.of(context).size.width < 600
                  ? horizontalSpaceSmallMobile
                  : horizontalSpaceSmall,
              TopNavigationBarItem(
                text: "Near Me",
                route: MapScreen.routeName,
              ),
              MediaQuery.of(context).size.width < 600
                  ? horizontalSpaceSmallMobile
                  : horizontalSpaceSmall,
              Visibility(
                visible: hasSearch,
                child: SizedBox(
                  width: 0.25 * screenSize.width,
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width < 600
                ? marginHorizontalMobile
                : marginHorizontal,
            child: Visibility(
              visible: hasAccount,
              child: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (ctx, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting)
                    return SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        color: Colors.grey,
                      ),
                    );
                  if (userSnapshot.hasData) {
                    return FutureBuilder(
                      future: UserController.getUser(),
                      builder: (ctx, futureResult) {
                        if (futureResult.connectionState ==
                            ConnectionState.waiting)
                          return SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                              color: Colors.grey,
                            ),
                          );
                        if (futureResult.data!.userImageUrl == null) {
                          return IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(AccountScreen.routeName);
                            },
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                            splashRadius:
                                MediaQuery.of(context).size.width < 600
                                    ? 25
                                    : null,
                            icon: Icon(
                              Icons.account_circle,
                              size: 30,
                            ),
                          );
                        }
                        return InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(AccountScreen.routeName);
                          },
                          child: ClipOval(
                            child: Image.network(
                                "http://127.0.0.1:8000${futureResult.data!.userImageUrl!}"),
                          ),
                        );
                      },
                    );
                  }
                  return IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(LogInScreen.routeName);
                    },
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    splashRadius:
                        MediaQuery.of(context).size.width < 600 ? 25 : null,
                    icon: Icon(
                      Icons.account_circle,
                      size: 30,
                    ),
                  );
                },
              ),
            ),
          ),
          Visibility(
            child: horizontalSpaceMarginMobile,
            visible: MediaQuery.of(context).size.width < 600,
          )
        ],
      ),
    );
  }
}
