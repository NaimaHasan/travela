import 'package:flutter/material.dart';

class EditInformationScreenDesktop extends StatelessWidget {
  const EditInformationScreenDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height - 120,
          width: 450,
          child: Card(
            elevation: 5,
            //color: Colors.black12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Edit Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Container(
                  height: 60,
                ),
                SizedBox(
                  width: 350,
                  child: TextField(
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                      labelText: 'Enter your E-mail',
                      labelStyle: const TextStyle(
                        fontSize: 15,
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                ),
                SizedBox(
                  width: 350,
                  child: TextField(
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                      labelText: 'Enter password',
                      labelStyle: const TextStyle(
                        fontSize: 15,
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                ),
                SizedBox(
                  width: 300,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Done',
                      style: TextStyle(),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
