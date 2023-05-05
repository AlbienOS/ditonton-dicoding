import 'dart:io';

import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_series_local_data_source.dart';
import 'package:core/data/datasources/tv_series_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_series_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/domain/usecases/movie/get_movie_detail.dart';
import 'package:core/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movie/get_popular_movies.dart';
import 'package:core/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:core/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:core/domain/usecases/movie/get_watchlist_status.dart';
import 'package:core/domain/usecases/movie/remove_watchlist.dart';
import 'package:core/domain/usecases/movie/save_watchlist.dart';
import 'package:core/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_recommendation.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_status_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:core/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:core/domain/usecases/tv_series/save_watchlist_tv_series.dart';
import 'package:core/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:core/presentation/bloc/movie/now_playing/now_playing_bloc.dart';
import 'package:core/presentation/bloc/movie/popular/popular_bloc.dart';
import 'package:core/presentation/bloc/movie/top_rated/top_rated_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:core/presentation/bloc/tv_series/now_playing_tv_series/now_playing_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tv_series/popular/popular_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tv_series/top_rated/top_rated_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tv_series/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:core/presentation/bloc/tv_series/tv_series_recommendation/tv_series_recommendation_bloc.dart';
import 'package:core/presentation/bloc/tv_series/tv_series_watchlist/tv_series_watchlist_bloc.dart';
import 'package:core/presentation/bloc/tv_series/watchlist_tv_series.dart/watchlist_tv_series_bloc.dart';
import 'package:core/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:core/presentation/provider/movie/movie_list_notifier.dart';
import 'package:core/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:core/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:core/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:core/presentation/provider/tv_series/now_playing_tv_series_notifier.dart';
import 'package:core/presentation/provider/tv_series/popular_tv_series_notifier.dart';
import 'package:core/presentation/provider/tv_series/tv_series_detail_notifier.dart';
import 'package:core/presentation/provider/tv_series/tv_series_list.dart';
import 'package:core/presentation/provider/tv_series/watchlist_tv_series_notifier.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';
import 'package:search/bloc/bloc_movie/search_bloc.dart';
import 'package:search/bloc/bloc_tv_series/searc_tv_series_bloc.dart';
import 'package:search/domain/usecase/search_movies.dart';
import 'package:search/domain/usecase/search_tv_series.dart';
import 'package:search/presentation/provider/movie/movie_search_notifier.dart';
import 'package:search/presentation/provider/tv_series/tv_series_search_notifier.dart';

final locator = GetIt.instance;

void init() {
  locator.registerSingletonAsync<IOClient>(() async {
    final sslCer = await rootBundle.load('certificate/themoviedb.org.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCer.buffer.asInt8List());
    final http = HttpClient(context: securityContext);
    return IOClient(http);
  });

  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
      () => PopularTvSeriesNotifier(getPopularTvSeries: locator()));
  locator.registerFactory(
      () => NowPlayingTvSeriesNotifier(getNowPlayingTvSeries: locator()));
  locator.registerFactory(() => TvSeriesDetailNotifier(
      getTvSeriesDetail: locator(),
      getTvSeriesRecommendations: locator(),
      getWatchlistStatusTvSeries: locator(),
      saveWatchlistTvSeries: locator(),
      removeWatchlistTvSeries: locator()));
  locator.registerFactory(() => TvSeriesListNotifier(
      getNowPlayingTvSeries: locator(),
      getPopularTvSeries: locator(),
      getTopRatedTvSeries: locator()));
  locator
      .registerFactory(() => TvSeriesSearchNotifier(searchTvSeries: locator()));
  locator.registerFactory(
      () => WatchlistTvSeriesNotifier(getWatchlistTvSeries: locator()));

  //bloc
  locator.registerFactory(() => SearchBloc(locator()));
  locator.registerFactory(() => SearchTvSeriesBloc(locator()));
  locator.registerFactory(() => MovieDetailBloc(locator()));
  locator.registerFactory(() => MovieRecommendationBloc(locator()));
  locator.registerFactory(() => MovieWatchlistBloc(
      insertWatchlist: locator(),
      removeWatchlist: locator(),
      getWatchListStatus: locator()));
  locator.registerFactory(() => NowPlayingBloc(locator()));
  locator.registerFactory(() => PopularBloc(locator()));
  locator.registerFactory(() => TopRatedBloc(locator()));
  locator.registerFactory(() => WatchlistMovieBloc(locator()));
  locator.registerFactory(() => NowPlayingTvSeriesBloc(locator()));
  locator.registerFactory(() => PopularTvSeriesBloc(locator()));
  locator.registerFactory(() => TopRatedTvSeriesBloc(locator()));
  locator.registerFactory(() => TvSeriesDetailBloc(locator()));
  locator.registerFactory(() => TvSeriesRecommendationBloc(locator()));
  locator.registerFactory(() => TvSeriesWatchlistBloc(
      insertWatchlistTvSeries: locator(),
      removeWatchlistTvSeries: locator(),
      getWatchlistStatusTvSeries: locator()));
  locator.registerFactory(() => WatchlistTvSeriesBloc(locator()));

  // use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  //use case tv series
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendation(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistStatusTvSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvSeriesRepository>(() =>
      TvSeriesRepositoryImpl(
          remoteDataSource: locator(), localDataSource: locator()));

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesDataSourceImpl(databaseHelper: locator()));
  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
