import 'package:flutter/material.dart';
import 'package:travela/widgets/common/pill_button.dart';

import '../../../widgets/common/spacing.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(5.0), bottomLeft: Radius.circular(5.0)),
                      child: Image.asset(
                        'lib/assets/mock_1.jpg',
                        fit: BoxFit.fitWidth,
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
              width: 0.35 * screenSize.width,
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
                      Text(
                        "Honolulu",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  ),
                  horizontalSpaceMedium,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
