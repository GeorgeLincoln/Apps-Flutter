class Data {
  String id;
  String name;
  int age;

  Data({
    required this.id,
    required this.name,
    required this.age,
  });

  static Data fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
        name: json['name'],
        age: json['age'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "age": age,
      };
}
