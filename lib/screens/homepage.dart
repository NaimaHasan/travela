import 'package:flutter/material.dart';
import 'package:travela/widgets/homescreen/home_carousel.dart';
import 'package:travela/widgets/homescreen/home_pill.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Container(
              color: Color.fromARGB(255, 200, 200, 200),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20, top: 20),
                    child: Text(
                      'Travela',
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: Container(),
                  ),
                  SizedBox(
                    width: 400,
                    child: SizedBox(
                      height: 38,
                      child: TextField(
                        style: const TextStyle(fontSize: 16),
                        // textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search),
                            iconSize: 24,
                            splashRadius: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                HomePill(title: 'Destinations'),
                SizedBox(width: 12),
                HomePill(title: 'Hotels'),
                SizedBox(width: 12),
                HomePill(title: 'Restaurants'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                HomePill(title: 'Hospitals'),
                SizedBox(width: 12),
                HomePill(title: 'Public Washrooms'),
              ],
            ),
            const Padding(
              padding:
                  EdgeInsets.only(bottom: 20, left: 15, right: 15, top: 30),
              child: Text(
                'Hot Destinations',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const HomeCarousel(),
            const Padding(
              padding:
                  EdgeInsets.only(top: 30, bottom: 20, left: 15, right: 15),
              child: Text(
                'Amsterdam',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const HomeCarousel(),
            const SizedBox(height: 50),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.map),
      ),
    );
  }
}
