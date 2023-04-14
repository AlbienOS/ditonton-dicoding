import 'dart:convert';

import 'package:core/data/models/movie/genre_model.dart';
import 'package:core/data/models/movie/movie_table.dart';
import 'package:core/data/models/tv_series/season_model.dart';
import 'package:core/data/models/tv_series/tv_series_detail_model.dart';
import 'package:core/data/models/tv_series/tv_series_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';

final tTvSeriesDetailModel = TvSeriesDetailModel(
  id: 2,
  genres: _genreModel,
  posterPath: '/a',
  name: 'A',
  voteAverage: 7.5,
  voteCount: 40,
  status: 'Released',
  firstAirDate: '2020-10-11',
  overview: 'A people who thinks they are great.',
  originalLanguage: 'en',
  originalName: '月は君の嘘',
  numberOfEpisodes: 22,
  numberOfSeasons: 2,
);

final ttvSeriesDetailModel = TvSeriesDetailModel(
  id: 2,
  genres: _genreModel,
  posterPath: '/a',
  name: 'A',
  voteAverage: 7.5,
  voteCount: 40,
  status: 'Released',
  firstAirDate: '2020-10-11',
  overview: 'A people who thinks they are great.',
  originalLanguage: 'en',
  originalName: '月は君の嘘',
  numberOfEpisodes: 22,
  numberOfSeasons: 2,
);
final tTvSeriesDetail = TvSeriesDetail(
  id: 2,
  genres: _genres,
  posterPath: '/a',
  name: 'A',
  voteAverage: 7.5,
  voteCount: 40,
  status: 'Released',
  firstAirDate: '2020-10-11',
  overview: 'A people who thinks they are great.',
  originalLanguage: 'en',
  originalName: '月は君の嘘',
  numberOfEpisodes: 22,
  numberOfSeasons: 2,
);

final testTvSeriesDetail = TvSeriesDetail(
    id: 2,
    genres: _genres,
    posterPath: 'posterPath',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    status: 'status',
    firstAirDate: 'firstAirDate',
    overview: 'overview',
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    numberOfEpisodes: 1,
    numberOfSeasons: 1);

final ttvSeries = TvSeries(
  posterPath: "/aurZJ8UsXqhGwwBnNuZsPNepY8y.jpg",
  id: 64122,
  name: "The Shannara Chronicles",
  overview:
      "A young Healer armed with an unpredictable magic guides a runaway Elf in her perilous quest to save the peoples of the Four Lands from an age-old Demon scourge.",
);

final ttvSeriesModels = TvSeriesModel(
  posterPath: "posterPath",
  id: 2,
  name: "name",
  overview: "overview",
);

final testTvSeries = {
  'id': 64122,
  'name': 'The Shannara Chronicles',
  'overview':
      'A young Healer armed with an unpredictable magic guides a runaway Elf in her perilous quest to save the peoples of the Four Lands from an age-old Demon scourge.',
  'poster_path': '/aurZJ8UsXqhGwwBnNuZsPNepY8y.jpg',
};
final testTvSeriesList = [ttvSeries];

final tTvSeriesModelRecommendations = <TvSeriesModel>[
  TvSeriesModel(
    posterPath: "/aurZJ8UsXqhGwwBnNuZsPNepY8y.jpg",
    id: 64122,
    name: "The Shannara Chronicles",
    overview:
        "A young Healer armed with an unpredictable magic guides a runaway Elf in her perilous quest to save the peoples of the Four Lands from an age-old Demon scourge.",
  ),
  TvSeriesModel(
    posterPath: "/8T8bAVzaKKyDNGQ6DQB3HF80wbJ.jpg",
    id: 44305,
    name: "DreamWorks Dragons",
    overview:
        "DreamWorks Dragons is an American computer-animated television series airing on Cartoon Network based on the 2010 film How to Train Your Dragon. The series serves as a bridge between the first film and its 2014 sequel. Riders of Berk follows Hiccup as he tries to keep balance within the new cohabitation of Dragons and Vikings. Alongside keeping up with Berk's newest installment — A Dragon Training Academy — Hiccup, Toothless, and the rest of the Viking Teens are put to the test when they are faced with new worlds harsher than Berk, new dragons that can't all be trained, and new enemies who are looking for every reason to destroy the harmony between Vikings and Dragons all together.",
  ),
  TvSeriesModel(
    posterPath: "/ydmfheI5cJ4NrgcupDEwk8I8y5q.jpg",
    id: 1405,
    name: "Dexter",
    overview:
        "Dexter is an American television drama series. The series centers on Dexter Morgan, a blood spatter pattern analyst for 'Miami Metro Police Department' who also leads a secret life as a serial killer, hunting down criminals who have slipped through the cracks of justice.",
  )
];

final tTvSeriesRecommendation =
    List<TvSeries>.from(tTvSeriesModelRecommendations.map((e) => e.toEntity()));

final tTvSeriesWatchlist = List<TvSeries>.from(tTvSeriesRecommendation);

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistTvSeries = TvSeries.watchlist(
    id: 2, name: "name", overview: "overview", posterPath: "posterPath");

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final _genreModel = [
  GenreModel(id: 123, name: "Action"),
  GenreModel(id: 234, name: "Sports")
];

final _genres =
    List<Genre>.from(_genreModel.map((e) => e.toEntity()), growable: false);

final seasonModel = SeasonModel(
    id: 2,
    posterPath: '/2b.jpg',
    name: 'Season 2',
    overview: 'overview',
    seasonNumber: 2);

final seasonToEntity = Season(
    id: 2,
    posterPath: '/2b.jpg',
    name: 'Season 2',
    overview: 'overview',
    seasonNumber: 2);
