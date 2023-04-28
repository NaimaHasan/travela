class Trip {
  const Trip({
    required this.owner,
    required this.tripName,
    required this.tripImageUrl,
    required this.startDate,
    required this.endDate,
    this.sharedUsers = const [],
  });

  Trip.fromJson(Map<String, dynamic> json)
      : owner = json['owner'],
        tripName = json['tripName'],
        tripImageUrl = json['tripImage'],
        startDate = DateTime.parse(json['startDate']),
        endDate = DateTime.parse(json['endDate']),
        sharedUsers = List<String>.from(json['sharedUsers']);

  final String owner;
  final String tripName;
  final String tripImageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> sharedUsers;

  @override
  String toString() {
    return "$owner $tripName \"$tripImageUrl\" $startDate $endDate $sharedUsers";
  }
}
