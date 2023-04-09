import 'package:flutter/material.dart';

class AccountScreenDesktop extends StatelessWidget {
  const AccountScreenDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.account_circle_outlined,
                      size: 300,
                    ),
                  ),
                  Container(
                    width: 150,
                  ),
                  Column(
                    children: [
                      const Text(
                        'John Doe',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            'Edit Information',
                            style: TextStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: 30,
              ),
            ],
          ),
        ),

    );
  }
}
