class JsonDecodeModel {
  String position;
  String name;
  String type;
  String radius;
  String orbital_period;
  String gravity;
  String velocity;
  String distance;
  String description;
  String image;
  String age;
  bool favorite;
  List<String> images;

  JsonDecodeModel({
    required this.position,
    required this.name,
    required this.type,
    required this.radius,
    required this.orbital_period,
    required this.gravity,
    required this.velocity,
    required this.distance,
    required this.description,
    required this.image,
    required this.images,
    required this.favorite,
    required this.age,
  });

  factory JsonDecodeModel.map({required Map data}) {
    return JsonDecodeModel(
      position: data['position'],
      name: data['name'],
      type: data['type'],
      radius: data['radius'],
      orbital_period: data['orbital_period'],
      gravity: data['gravity'],
      velocity: data['velocity'],
      distance: data['distance'],
      description: data['description'],
      image: data['image'],
      age: data['age'],
      images: List<String>.from(data["images"].map((x) => x)),
      favorite: false,
    );
  }
}

class FavoriteModel {
  List<JsonDecodeModel> favoriteList;

  FavoriteModel({required this.favoriteList});
}
