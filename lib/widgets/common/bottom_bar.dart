
import 'package:flutter/material.dart';
import 'package:travela/widgets/common/spacing.dart';


//A stateless widget for displaying the bottom bar
class BottomBar extends StatelessWidget {
  static const double bottomBarHeight = 100;
  //Constructor
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Displays the card for the bottom bar
    return Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      elevation: 20,
      child: Container(
        height: bottomBarHeight,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: Row(
          children: [
            MediaQuery.of(context).size.width < 600
                ? horizontalSpaceMarginMobile
                : horizontalSpaceMargin,
            //Displays the website icon
            Image.asset(
              "lib/assets/logo_128.png",
              height: 30,
            ),
            const SizedBox(width: 10),
            //Displays the website name
            const Text(
              "Travela",
              style: TextStyle(fontSize: 22),
            ),
            Container(
              color: Colors.grey,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: 1,
              height: 60,
            ),
            const Text("Follow"),
            const SizedBox(width: 5),
            //Displays the website developers github accounts
            Tooltip(
              message: "imranZMiko",
              verticalOffset: 15,
              child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "lib/assets/github-mark/github-mark-64.png",
                  height: 55,
                ),
                splashRadius: 18,
              ),
            ),
            Tooltip(
              message: "NaimaHasan",
              verticalOffset: 15,
              child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "lib/assets/github-mark/github-mark-64.png",
                  height: 55,
                ),
                splashRadius: 18,
              ),
            ),
            Container(
              color: Colors.grey,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: 1,
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text("© Travela"),
            ),
          ],
        ),
      ),
    );
  }
}
