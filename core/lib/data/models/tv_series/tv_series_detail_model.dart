import 'package:core/data/models/movie/genre_model.dart';
import 'package:core/data/models/tv_series/season_model.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv_series_detail.dart';

class TvSeriesDetailModel extends Equatable {
  final int id;
  final List<GenreModel> genres;
  final List<SeasonModel>? seasons;
  final String posterPath;
  final String name;
  final num voteAverage;
  final int voteCount;
  final String status;
  final String firstAirDate;
  final String overview;
  final String originalLanguage;
  final String originalName;
  final int numberOfSeasons;
  final int numberOfEpisodes;

  TvSeriesDetailModel(
      {this.seasons,
      required this.id,
      required this.genres,
      required this.posterPath,
      required this.name,
      required this.voteAverage,
      required this.voteCount,
      required this.status,
      required this.firstAirDate,
      required this.overview,
      required this.originalLanguage,
      required this.originalName,
      required this.numberOfSeasons,
      required this.numberOfEpisodes});

  factory TvSeriesDetailModel.fromJson(Map<String, dynamic> json) {
    final int id = json['id'];
    final List<GenreModel> genres =
        (json['genres'] as List).map((e) => GenreModel.fromJson(e)).toList();
    List<SeasonModel>? seasons;
    if (json['seasons'] != null) {
      seasons = (json['seasons'] as List)
          .map((e) => SeasonModel.fromJson(e))
          .toList();
    }
    final String posterPath = json['poster_path'];
    final String name = json['name'];
    final num voteAverage = json['vote_average'];
    final int voteCount = json['vote_count'];
    final String status = json['status'];
    final String firstAirDate = json['first_air_date'];
    final String overview = json['overview'];
    final String originalLanguage = json['original_language'];
    final String originalName = json['original_name'];
    final int numberOfEpisodes = json['number_of_episodes'];
    final int numberOfSeasons = json['number_of_seasons'];

    return TvSeriesDetailModel(
        id: id,
        genres: genres,
        seasons: seasons,
        posterPath: posterPath,
        name: name,
        voteAverage: voteAverage,
        voteCount: voteCount,
        status: status,
        firstAirDate: firstAirDate,
        overview: overview,
        originalLanguage: originalLanguage,
        originalName: originalName,
        numberOfSeasons: numberOfSeasons,
        numberOfEpisodes: numberOfEpisodes);
  }

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
        id: id,
        genres: genres.map((e) => e.toEntity()).toList(),
        seasons: seasons != null
            ? (seasons!.map((e) => e.toEntity()).toList())
            : null,
        posterPath: posterPath,
        name: name,
        voteAverage: voteAverage,
        voteCount: voteCount,
        status: status,
        firstAirDate: firstAirDate,
        overview: overview,
        originalLanguage: originalLanguage,
        originalName: originalName,
        numberOfSeasons: numberOfSeasons,
        numberOfEpisodes: numberOfEpisodes);
  }

  @override
  List<Object?> get props => [
        id,
        genres,
        seasons,
        name,
        voteAverage,
        voteCount,
        status,
        firstAirDate,
        overview,
        originalLanguage,
        originalName,
        posterPath
      ];
}
