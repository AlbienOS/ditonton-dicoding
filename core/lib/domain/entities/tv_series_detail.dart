import 'package:core/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/movie/genre_model.dart';
import '../../data/models/tv_series/season_model.dart';
import 'genre.dart';

class TvSeriesDetail extends Equatable {
  final int id;
  final List<Genre> genres;
  final List<Season>? seasons;
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

  TvSeriesDetail(
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
