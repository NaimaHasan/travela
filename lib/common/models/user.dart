class TravelaUser {
  const TravelaUser(
      {required this.userEmail,
      required this.userName,
      this.userImageUrl});

  TravelaUser.fromJson(Map<String, dynamic> json)
      : userEmail = json['userEmail'],
        userName = json['userName'],
        userImageUrl = json['userImage'];

  final String userEmail;
  final String userName;
  final String? userImageUrl;

  @override
  String toString() {
    return "$userEmail $userName \"$userImageUrl\"";
  }
}
