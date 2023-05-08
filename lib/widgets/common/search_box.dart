import 'package:flutter/material.dart';

import '../../screens/search/search_screen.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    super.key,
    required this.width,
  });

  final double width;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void search() {
    Navigator.of(context).pushNamed("${SearchScreen.routeName}/${_controller.text}");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextField(
        controller: _controller,
        onSubmitted: (_){
          search();
        },
        decoration: InputDecoration(
          prefixIcon: IconButton(
            onPressed: (){
              search();
            },
            icon: Icon(Icons.search),
          ),
          contentPadding:
          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
