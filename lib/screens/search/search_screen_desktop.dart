import 'package:flutter/material.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

final List<Widget> imageSliders = imgList
    .map(
      (item) => ClipRRect(
    child: Stack(
      children: <Widget>[
        Image.network(item, fit: BoxFit.cover, width: 1500.0),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(200, 0, 0, 0),
                  Color.fromARGB(0, 0, 0, 0)
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            padding: const EdgeInsets.only(
                top: 30.0, left: 12, bottom: 10, right: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Destination Name",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.location_on_outlined,
                    color: Colors.amber,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
)
    .toList();

class SearchScreenDesktop extends StatelessWidget {
  const SearchScreenDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
          SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                38 -
                40,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: imageSliders.length,
              itemBuilder: (ctx, index) {
                return imageSliders[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}