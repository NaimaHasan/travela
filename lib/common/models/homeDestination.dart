class HomeDestination {
  const HomeDestination(
      {required this.name,
        required this.image,
        required this.tag,
        required this.location});

  HomeDestination.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        image =json['image'],
        tag = json['tag'],
        location = json['description'];

  final String name;
  final String image;
  final String tag;
  final String location;

  @override
  String toString() {
    return "$name \"$image\"";
  }
}