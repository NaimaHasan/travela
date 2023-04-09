import 'package:flutter/material.dart';

class DestinationImage extends StatelessWidget {
  const DestinationImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 8,
      child: Stack(
        children: [
          OrientationBuilder(
            builder: (context, orientation) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: orientation == Orientation.portrait
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.height,
                child: Image.asset(
                  'lib/assets/dummy.jpg',
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          Positioned(
            bottom: 0,
            child: OrientationBuilder(
              builder: (context, orientation) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.width - 150
                      : MediaQuery.of(context).size.height - 50,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black87,
                        Colors.transparent,
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 10,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Chhayanaut',
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
