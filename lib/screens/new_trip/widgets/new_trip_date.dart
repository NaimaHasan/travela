import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewTripDate extends StatefulWidget {
  NewTripDate({required this.title, required this.data, Key? key})
      : super(key: key);
  final String title;
  final String data;
  @override
  _NewTripDateState createState() => _NewTripDateState();
}

class _NewTripDateState extends State<NewTripDate> {
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
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(6))),
        width: 350,
        height: 60,
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.calendar_today_outlined),
                  iconSize: 24,
                  splashRadius: 12,
                  color: Colors.black54,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
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
                      contentPadding:
                          EdgeInsets.only(top: 0, left: 10, bottom: 15),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
