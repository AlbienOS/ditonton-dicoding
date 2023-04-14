import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesModel extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String? posterPath;

  TvSeriesModel(
      {required this.id,
      required this.name,
      required this.overview,
      this.posterPath});

  factory TvSeriesModel.fromEntity(TvSeriesDetail tvSeriesDetail) =>
      TvSeriesModel(
          id: tvSeriesDetail.id,
          name: tvSeriesDetail.name,
          overview: tvSeriesDetail.overview,
          posterPath: tvSeriesDetail.posterPath);

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) => TvSeriesModel(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      posterPath: json['poster_path']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
      };

  TvSeries toEntity() {
    return TvSeries(
        id: this.id,
        name: this.name,
        overview: this.overview,
        posterPath: this.posterPath);
  }

  @override
  List<Object?> get props => [id, name, overview, posterPath];
}
