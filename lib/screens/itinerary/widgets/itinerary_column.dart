import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travela/common/api/itineraryController.dart';
import 'package:travela/common/models/itineraryEntry.dart';

import '../../../common/models/trip.dart';
import 'itinerary_header.dart';
import 'itinerary_item.dart';

class ItineraryColumn extends StatefulWidget {
  const ItineraryColumn(
      {Key? key, required this.trip, required this.isScrollable, required this.refreshMarkers})
      : super(key: key);

  final Trip trip;
  final bool isScrollable;
  final VoidCallback refreshMarkers;

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
          return const Center(child: CircularProgressIndicator());
        }
        if (!futureResult.hasData) {
          return const Text("No Itinerary Entries");
        }
        return SizedBox(
          height:
              widget.isScrollable ? MediaQuery.of(context).size.height : null,
          child: Stack(
            children: [
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics:
                    widget.isScrollable ? null : const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                itemCount: futureResult.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = futureResult.data![index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                        visible: index == 0
                            ? true
                            : (futureResult.data![index].dateTime.day -
                                        futureResult
                                            .data![index - 1].dateTime.day)
                                    .abs() !=
                                0,
                        child: ItineraryHeader(
                          text:
                              "${DateFormat.E().format(data.dateTime)}, ${DateFormat.MMMd().format(data.dateTime)}",
                          isMiddle: index != 0,
                        ),
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
                            widget.refreshMarkers();
                          });
                        },
                        isNext: (index == 0 && data.dateTime.isAfter(DateTime.now())) || (data.dateTime.isAfter(DateTime.now()) && futureResult.data![index - 1].dateTime.isBefore(DateTime.now())),
                        trip: widget.trip,
                      ),
                      Visibility(
                        visible: index == futureResult.data!.length - 1,
                        child: const SizedBox(
                          height: 75,
                        ),
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
                          context, widget.trip.tripID!, widget.trip
                      );
                      setState(() {
                        _future = ItineraryController.getAllEntries(
                            widget.trip.tripID!);
                        widget.refreshMarkers();
                      });
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
