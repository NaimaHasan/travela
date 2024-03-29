import 'package:flutter/material.dart';

import '../../screens/search/search_screen.dart';

//A stateful widget for displaying the search box
class SearchBox extends StatefulWidget {
  //Constructor
  const SearchBox({
    super.key,
    required this.width, this.initialString,
  });

  final double width;
  final String? initialString;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if(widget.initialString != null) {
      _controller.text = widget.initialString!.replaceAll("%20", " ");
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void search() {
    Navigator.of(context).pushNamed("${SearchScreen.routeName}/${_controller.text.toLowerCase()}");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      //Text field for the search box
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
            icon: const Icon(Icons.search),
          ),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
