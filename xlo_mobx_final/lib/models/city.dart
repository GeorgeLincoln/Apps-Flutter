class City {
  City({this.id, this.name});

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json['id'],
        name: json['nome'],
      );

  int id;
  String name;

  @override
  String toString() {
    return 'City{id: $id, name: $name}';
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": name,
      };
}
