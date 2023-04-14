import 'package:equatable/equatable.dart';

import '../../../domain/entities/season.dart';

class SeasonModel extends Equatable {
  final int id;
  final String? posterPath;
  final String name;
  final String overview;
  final int seasonNumber;

  SeasonModel({
    this.posterPath,
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
      id: json['id'],
      posterPath: json['poster_path'],
      name: json['name'],
      overview: json['overview'],
      seasonNumber: json['season_number']);

  Season toEntity() {
    return Season(
        id: id,
        posterPath: posterPath,
        name: name,
        overview: overview,
        seasonNumber: seasonNumber);
  }

  List<Object?> get props => [id, posterPath, name, overview, seasonNumber];
}
