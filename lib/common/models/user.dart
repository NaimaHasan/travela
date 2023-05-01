class TravelaUser {
  const TravelaUser(
      {required this.userEmail,
      required this.userName,
      this.userImageUrl,
      this.pendingRequests,
      this.acceptedRequests});

  TravelaUser.fromJson(Map<String, dynamic> json)
      : userEmail = json['userEmail'],
        userName = json['userName'],
        userImageUrl = json['userImage'],
        pendingRequests = List<int>.from(json['pendingRequests']),
        acceptedRequests = List<int>.from(json['acceptedRequests']);

  final String userEmail;
  final String userName;
  final String? userImageUrl;
  final List<int>? pendingRequests;
  final List<int>? acceptedRequests;

  @override
  String toString() {
    return "$userEmail $userName \"$userImageUrl\"";
  }
}
