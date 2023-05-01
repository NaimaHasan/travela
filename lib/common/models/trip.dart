class Trip {
  const Trip({
    this.tripID,
    required this.owner,
    required this.tripName,
    this.tripImageUrl = "",
    required this.startDate,
    required this.endDate,
    this.pendingUsers = const [],
    this.sharedUsers = const [],
  });

  Trip.fromJson(Map<String, dynamic> json)
      : tripID = json['id'],
        owner = json['owner'],
        tripName = json['tripName'],
        tripImageUrl = json['tripImage'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        pendingUsers = List<String>.from(json['pendingUsers']),
        sharedUsers = List<String>.from(json['sharedUsers']);

  final int? tripID;
  final String owner;
  final String tripName;
  final String? tripImageUrl;
  final String startDate;
  final String endDate;
  final List<String> pendingUsers;
  final List<String> sharedUsers;

  @override
  String toString() {
    return "$owner $tripName \"$tripImageUrl\" $startDate $endDate $pendingUsers $sharedUsers";
  }
}
