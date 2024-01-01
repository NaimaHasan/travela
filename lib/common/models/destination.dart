
//Model class for destination
class Destination {
  //Constructor
  const Destination(
      {required this.name,
      required this.address,
      required this.image,
      required this.tag,
      this.description});

  Destination.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        address = json['address'],
        image = List<String>.from(json['image']),
        tag = json['tag'],
        description = json['description'];

  //Fields of the model
  final String name;
  final String address;
  final List<String> image;
  final String tag;
  final String? description;

  @override
  String toString() {
    return "$name $name \"$image\"";
  }
}
