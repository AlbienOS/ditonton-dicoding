import 'package:core/data/models/movie/movie_model.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv_series.dart';

final tMovieModel = Movie(
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

final tMovieList = <Movie>[tMovieModel];
final tQuery = 'Spiderman';

final tTvSeriesModel = TvSeries(
    id: 1, name: 'name', overview: 'overview', posterPath: 'poster_path');
final tTvSeriesList = <TvSeries>[tTvSeriesModel];
final tQueryTvSeries = 'Thrones';
