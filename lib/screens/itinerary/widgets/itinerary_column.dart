import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travela/common/api/itineraryController.dart';
import 'package:travela/common/models/itineraryEntry.dart';

import '../../../common/api/tripController.dart';
import '../../../common/models/trip.dart';
import 'itinerary_header.dart';
import 'itinerary_item.dart';

class ItineraryColumn extends StatefulWidget {
  const ItineraryColumn(
      {Key? key, required this.trip, required this.isScrollable})
      : super(key: key);

  final Trip trip;
  final bool isScrollable;

  @override
  State<ItineraryColumn> createState() => _ItineraryColumnState();
}

class _ItineraryColumnState extends State<ItineraryColumn> {
  late Future<List<ItineraryEntry>> _future;

  @override
  void initState() {
    _future = ItineraryController.getAllEntries(widget.trip.tripID!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (ctx, futureResult) {
        if (futureResult.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator()
          );
        }
        if (!futureResult.hasData) {
          return Text("No Itinerary Entries");
        }
        return Stack(
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics:
                  widget.isScrollable ? null : NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              itemCount: futureResult.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var data = futureResult.data![index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                      child: ItineraryHeader(
                        text:
                            "${DateFormat.E().format(data.dateTime)}, ${DateFormat.MMMd().format(data.dateTime)}",
                        isMiddle: index != 0,
                      ),
                      visible: index == 0
                          ? true
                          : (futureResult.data![index].dateTime.day -
                                      futureResult
                                          .data![index - 1].dateTime.day)
                                  .abs() !=
                              0,
                    ),
                    ItineraryItem(
                        time: DateFormat('h:mm a').format(data.dateTime),
                        description: data.description,
                        isStart: index == 0,
                        isEnd: index == futureResult.data!.length - 1,
                        entry: futureResult.data![index],
                        refresh: () {
                          setState(() {
                            _future = ItineraryController.getAllEntries(
                                widget.trip.tripID!);
                          });
                        }),
                    Visibility(
                      child: SizedBox(
                        height: 75,
                      ),
                      visible: index == futureResult.data!.length - 1,
                    ),
                  ],
                );
              },
            ),
            Visibility(
              visible: widget.isScrollable,
              child: Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () async {
                    await ItineraryController.newEntry(
                        context, widget.trip.tripID!);
                    setState(() {
                      _future = ItineraryController.getAllEntries(
                          widget.trip.tripID!);
                    });
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
