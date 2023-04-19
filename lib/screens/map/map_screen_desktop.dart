import 'package:flutter/material.dart';

class MapScreenDesktop extends StatelessWidget {
  const MapScreenDesktop({
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
        ],
      ),
    );
  }
}
