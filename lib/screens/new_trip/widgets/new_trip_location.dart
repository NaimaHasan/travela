import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewTripLocation extends StatefulWidget {
  NewTripLocation({required this.data, Key? key})
      : super(key: key);
  final String data;
  @override
  _NewTripLocationState createState() => _NewTripLocationState();
}

class _NewTripLocationState extends State<NewTripLocation> {
  bool isEnabled = false;
  IconData icon = Icons.edit;
  TextEditingController fieldData = TextEditingController();

  @override
  void initState() {
    fieldData.text = widget.data;
    super.initState();
  }

  @override
  void dispose() {
    fieldData.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(6))),
      width: 350,
      height: 50,
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.map_outlined),
                iconSize: 24,
                splashRadius: 12,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            height: 25,
            width: 250,
            child: TextFormField(
              controller: fieldData,
              enabled: isEnabled,
              style: TextStyle(fontSize: 15),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 0, left: 10, bottom: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
