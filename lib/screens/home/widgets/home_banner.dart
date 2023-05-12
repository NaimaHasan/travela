import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:travela/widgets/common/pill_button.dart';

import '../../../common/api/homeDestinationController.dart';
import '../../../common/models/homeDestination.dart';
import '../../../widgets/common/spacing.dart';
import '../../destination/destination_screen.dart';
import '../../new_trip/new_trip_screen.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
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
    return FutureBuilder(
      future: _future,
      builder: (ctx, futureResult) {
        if (futureResult.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!futureResult.hasData || futureResult.data == null) {
          return Center(
            child: Text("No destination available"),
          );
        }
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
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed("${DestinationScreen.routeName}/${futureResult.data!.name}");
                            },
                            child: Image.network(
                              futureResult.data!.image,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
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
                          Text(
                            "Destination",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            child: Text(
                              futureResult.data!.name,
                              style: TextStyle(
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
                      PillButton(
                        child: Text(
                          "Plan a trip now",
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        onPress: () {
                          Navigator.of(context)
                              .pushNamed(NewTripScreen.routeName, arguments: futureResult.data!.name);
                        },
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
