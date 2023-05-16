import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travela/screens/account/account_screen.dart';
import 'package:travela/screens/home/home_screen.dart';
import 'package:travela/screens/login/login_screen.dart';
import 'package:travela/screens/map/map_screen.dart';
import 'package:travela/widgets/common/search_box.dart';
import 'package:travela/widgets/common/spacing.dart';
import 'package:travela/widgets/common/top_navigation_bar_item.dart';

import '../../common/api/user_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

//A stateless widget for displaying the top navigation bar
class TopNavigationBar extends StatelessWidget {
  //Constructor
  const TopNavigationBar(
      {Key? key,
      this.hasSearch = true,
      this.hasAccount = true,
      this.searchString})
      : super(key: key);

  final bool hasSearch;
  final bool hasAccount;
  final String? searchString;

  @override
  Widget build(BuildContext context) {
    //Variable for screen size
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      child: Row(
        children: [
          MediaQuery.of(context).size.width < 600
              ? horizontalSpaceMarginMobile
              : horizontalSpaceMargin,
          //Calls the TopNavigationBarItem widget for website name
          const TopNavigationBarItem(
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
              //Calls the TopNavigationBarItem widget for home
              const TopNavigationBarItem(
                text: "Home",
                route: HomeScreen.routeName,
              ),
              MediaQuery.of(context).size.width < 600
                  ? horizontalSpaceSmallMobile
                  : horizontalSpaceSmall,
              //Calls the TopNavigationBarItem widget for near me
              const TopNavigationBarItem(
                text: "Near Me",
                route: MapScreen.routeName,
              ),
              MediaQuery.of(context).size.width < 600
                  ? horizontalSpaceSmallMobile
                  : horizontalSpaceSmall,
              //Displays the search box of the top navigation bar
              Visibility(
                visible: hasSearch,
                child: SearchBox(
                    width: 0.25 * screenSize.width,
                    initialString: searchString),
              ),
            ],
          ),
          //Displays the account logo of the top navigation bar
          //If the user is logged in and has user image displays the user image, else shows the default account image
          //If the user is logged in routes to account screen, else routes to log in screen
          SizedBox(
            width: MediaQuery.of(context).size.width < 600
                ? marginHorizontalMobile
                : marginHorizontal,
            child: Visibility(
              visible: hasAccount,
              child: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (ctx, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  }
                  if (userSnapshot.hasData) {
                    return Center(
                      //Future builder for account data
                      //Checks the relevant conditions and displays messages on screen accordingly
                      child: FutureBuilder(
                        future: UserController.getUser(),
                        builder: (ctx, futureResult) {
                          if (futureResult.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          }
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
                              icon: const Icon(
                                Icons.account_circle,
                                size: 30,
                              ),
                            );
                          }
                          //Routing for account logo
                          return InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AccountScreen.routeName);
                            },
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl:
                                    "http://127.0.0.1:8000${futureResult.data!.userImageUrl!}",
                                width: 35,
                                height: 35,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return IconButton(
                    onPressed: () {
                      //Routing for account logo
                      Navigator.of(context).pushNamed(LogInScreen.routeName);
                    },
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    splashRadius:
                        MediaQuery.of(context).size.width < 600 ? 25 : null,
                    icon: const Icon(
                      Icons.account_circle,
                      size: 30,
                    ),
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: MediaQuery.of(context).size.width < 600,
            child: horizontalSpaceMarginMobile,
          )
        ],
      ),
    );
  }
}
