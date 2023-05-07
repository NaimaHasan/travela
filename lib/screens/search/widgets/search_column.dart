import 'package:flutter/material.dart';
import 'package:travela/common/api/destinationController.dart';
import 'package:travela/screens/search/widgets/search_result_card.dart';

import '../../../common/models/destination.dart';

class SearchColumn extends StatefulWidget {
  const SearchColumn({
    super.key,
    required this.padding,
    required this.cardWidth,
    required this.searchTerm,
  });

  final String searchTerm;
  final EdgeInsetsGeometry padding;
  final double cardWidth;

  @override
  State<SearchColumn> createState() => _SearchColumnState();
}

class _SearchColumnState extends State<SearchColumn> {
  late Future<List<Destination>> searchResults;

  @override
  void initState() {
    searchResults = DestinationController.searchDestinations(widget.searchTerm);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: searchResults,
      builder: (ctx, futureResults) {
        if (futureResults.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!futureResults.hasData ||
            futureResults.data == null ||
            futureResults.data!.isEmpty) {
          return Center(
            child: Text("No results found"),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemCount: futureResults.data!.length,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: widget.padding,
              child: SearchResultCard(
                destination: futureResults.data![index],
                cardTextWidth: widget.cardWidth,
              ),
            );
          },
        );
      },
    );
  }
}
