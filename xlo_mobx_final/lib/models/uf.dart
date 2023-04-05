class UF {
  UF({this.id, this.initials, this.name});

  factory UF.fromJson(Map<String, dynamic> json) => UF(
        id: json['id'],
        initials: json['sigla'],
        name: json['nome'],
      );

  int id;
  String initials;
  String name;

  @override
  String toString() {
    return 'UF{id: $id, initials: $initials, name: $name}';
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "sigla": initials,
        "nome": name,
      };
}
