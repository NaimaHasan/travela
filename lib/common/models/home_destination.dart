
//Model class for home destination
class HomeDestination {
  //Constructor
  const HomeDestination(
      {required this.name,
        required this.image,
        required this.tag,
        required this.location});

  HomeDestination.fromJson(Map<String, dynamic> json)
      : name = json['destinationName'],
        image =json['destinationImage'],
        tag = json['destinationTag'],
        location = json['destinationLocation'];

  //Fields of the model
  final String name;
  final String image;
  final String tag;
  final String location;

  @override
  String toString() {
    return "$name \"$image\"";
  }
}