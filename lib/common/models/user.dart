class User {
  const User({
    required this.userID,
    required this.userName,
    required this.userImageUrl,
  });

  User.fromJson(Map<String, dynamic> json)
      : userID = json['userID'],
        userName = json['userName'],
        userImageUrl = json['userImageUrl'];

  final String userID;
  final String userName;
  final String userImageUrl;

  @override
  String toString() {
    return "$userID $userName \"$userImageUrl\"";
  }
}
