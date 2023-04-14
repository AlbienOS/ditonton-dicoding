import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) =>
      Genre(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
