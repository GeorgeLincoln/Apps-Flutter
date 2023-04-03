import 'package:flutter/material.dart';

class Doodle {
  final String id;
  final String name;
  final String time;
  final String content;
  final String doodle;

  const Doodle({
    required this.id,
    required this.name,
    required this.time,
    required this.content,
    required this.doodle,
  });

  static Doodle fromJson(Map<String, dynamic> json) => Doodle(
        id: json['id'],
        name: json['name'],
        time: json['time'],
        content: json['content'],
        doodle: json['doodle'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "time": time,
        "content": content,
        "doodle": doodle,
      };
}
