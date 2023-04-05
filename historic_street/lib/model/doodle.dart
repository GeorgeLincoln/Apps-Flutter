class Doodle {
  final String id;
  final String name;
  final String content;
  final String image;
  //final List<String> images;

  const Doodle({
    required this.id,
    required this.name,
    required this.content,
    required this.image,
    //required this.images,
  });

  static Doodle fromJson(Map<String, dynamic> json) => Doodle(
        id: json['id'],
        name: json['name'],
        content: json['content'],
        image: json['image'],
        //images: json['images']
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "content": content,
        "image": image,
        //"images": images,
      };

  factory Doodle.fromMap(Map<String, dynamic> map) {
    return Doodle(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      content: map['content'] ?? '',
      image: map['image'] ?? '',
      //images: map['images'] ?? '',
    );
  }
}
