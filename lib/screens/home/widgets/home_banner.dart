import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travela/widgets/common/pill_button.dart';

import '../../../common/api/homeDestinationController.dart';
import '../../../common/models/homeDestination.dart';
import '../../../widgets/common/spacing.dart';
import '../../destination/destination_screen.dart';
import '../../new_trip/new_trip_screen.dart';

//A stateful widget for displaying home banner
class HomeBanner extends StatefulWidget {
  //Constructor
  const HomeBanner({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  late Future<HomeDestination?> _future;

  @override
  void initState() {
    _future = HomeDestinationController.getHomeBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    //Future builder for home banner data
    //Checks the relevant conditions and displays messages on screen accordingly
    return FutureBuilder(
      future: _future,
      builder: (ctx, futureResult) {
        if (futureResult.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 0.65 * screenSize.height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (!futureResult.hasData || futureResult.data == null) {
          return SizedBox(
            height: 0.65 * screenSize.height,
            child: const Center(
              child: Text("No destination available"),
            ),
          );
        }
        //Stack for displaying home banner
        return Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    horizontalSpaceMargin,
                    Expanded(
                      child: SizedBox(
                        height: 0.65 * screenSize.height,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0)),
                          //If the home banner is tapped navigates to destination screen
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  "${DestinationScreen.routeName}/${futureResult.data!.name}");
                            },
                            child: CachedNetworkImage(
                              imageUrl: futureResult.data!.image,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
            //Card to display home banner information
            //Displays name, and a plan a trip button
            Positioned(
              bottom: 0,
              child: Card(
                elevation: 10,
                child: SizedBox(
                  width: 500,
                  height: 100,
                  child: Row(
                    children: [
                      horizontalSpaceMedium,
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Displays the destination tag
                          Text(
                            futureResult.data!.tag,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          //Displays the destination name
                          SizedBox(
                            width: 250,
                            child: Text(
                              futureResult.data!.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      //Pill button for displaying "Plan a trip now"
                      PillButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        onPress: () {
                          Navigator.of(context)
                              .pushNamed(NewTripScreen.routeName, arguments: [
                            futureResult.data!.name,
                            futureResult.data!.location
                          ]);
                        },
                        child: const Text(
                          "Plan a trip now",
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ),
                      horizontalSpaceMedium,
                    ],
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
