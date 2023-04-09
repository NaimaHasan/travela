import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AccountScreenDesktop extends StatelessWidget {
  const AccountScreenDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 500, right: 500, top: 90),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.account_circle,
                        size: 180,
                      ),
                    ),
                  ),
                  Container(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 10),
                      const Text(
                        'John Doe',
                        style: TextStyle(fontSize: 25),
                      ),
                      Container(
                        height: 35,
                      ),
                      SizedBox(
                        width: 140,
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            'Edit Information',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          '55',
                          style: TextStyle(fontSize: 35),
                        ),
                        Container(
                          height: 15,
                        ),
                        const Text(
                          'Trips',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(height: 20),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width - 1000,
                color: Colors.black45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
