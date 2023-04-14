// Mocks generated by Mockito 5.2.0 from annotations
// in search/test/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i7;
import 'dart:convert' as _i23;
import 'dart:typed_data' as _i24;

import 'package:core/data/datasources/db/database_helper.dart' as _i21;
import 'package:core/data/datasources/movie_local_data_source.dart' as _i19;
import 'package:core/data/datasources/movie_remote_data_source.dart' as _i17;
import 'package:core/data/datasources/tv_series_local_data_source.dart' as _i16;
import 'package:core/data/datasources/tv_series_remote_data_source.dart'
    as _i14;
import 'package:core/data/models/movie/movie_detail_model.dart' as _i4;
import 'package:core/data/models/movie/movie_model.dart' as _i18;
import 'package:core/data/models/movie/movie_table.dart' as _i20;
import 'package:core/data/models/tv_series/tv_series_detail_model.dart' as _i3;
import 'package:core/data/models/tv_series/tv_series_model.dart' as _i15;
import 'package:core/domain/entities/movie.dart' as _i9;
import 'package:core/domain/entities/movie_detail.dart' as _i10;
import 'package:core/domain/entities/tv_series.dart' as _i12;
import 'package:core/domain/entities/tv_series_detail.dart' as _i13;
import 'package:core/domain/repositories/movie_repository.dart' as _i6;
import 'package:core/domain/repositories/tv_series_repository.dart' as _i11;
import 'package:core/utils/failure.dart' as _i8;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i22;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeTvSeriesDetailModel_1 extends _i1.Fake
    implements _i3.TvSeriesDetailModel {}

class _FakeMovieDetailResponse_2 extends _i1.Fake
    implements _i4.MovieDetailResponse {}

class _FakeResponse_3 extends _i1.Fake implements _i5.Response {}

class _FakeStreamedResponse_4 extends _i1.Fake implements _i5.StreamedResponse {
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i6.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, _i10.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<_i2.Either<_i8.Failure, _i10.MovieDetail>>.value(
              _FakeEither_0<_i8.Failure, _i10.MovieDetail>())) as _i7
          .Future<_i2.Either<_i8.Failure, _i10.MovieDetail>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveWatchlist(
          _i10.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> removeWatchlist(
          _i10.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
}

/// A class which mocks [TvSeriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesRepository extends _i1.Mock
    implements _i11.TvSeriesRepository {
  MockTvSeriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>
      getNowPlayingTvSeries() => (super.noSuchMethod(
              Invocation.method(#getNowPlayingTvSeries, []),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i12.TvSeries>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>
      getPopularTvSeries() => (super.noSuchMethod(
              Invocation.method(#getPopularTvSeries, []),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i12.TvSeries>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>
      getTopRatedTvSeries() => (super.noSuchMethod(
              Invocation.method(#getTopRatedTvSeries, []),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i12.TvSeries>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, _i13.TvSeriesDetail>> getTvSeriesDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSeriesDetail, [id]),
              returnValue:
                  Future<_i2.Either<_i8.Failure, _i13.TvSeriesDetail>>.value(
                      _FakeEither_0<_i8.Failure, _i13.TvSeriesDetail>()))
          as _i7.Future<_i2.Either<_i8.Failure, _i13.TvSeriesDetail>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>
      getTvSeriesRecommendation(int? id) => (super.noSuchMethod(
              Invocation.method(#getTvSeriesRecommendation, [id]),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i12.TvSeries>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>> searchTvSeries(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvSeries, [query]),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i12.TvSeries>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveWatchlist(
          _i13.TvSeriesDetail? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [tvSeries]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> removeWatchlist(
          _i13.TvSeriesDetail? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tvSeries]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, bool>> getWatchlistStatus(int? tvId) =>
      (super.noSuchMethod(Invocation.method(#getWatchlistStatus, [tvId]),
              returnValue: Future<_i2.Either<_i8.Failure, bool>>.value(
                  _FakeEither_0<_i8.Failure, bool>()))
          as _i7.Future<_i2.Either<_i8.Failure, bool>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>
      getWatchlistTvSeries() => (super.noSuchMethod(
              Invocation.method(#getWatchlistTvSeries, []),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i12.TvSeries>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i12.TvSeries>>>);
}

/// A class which mocks [TvSeriesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesRemoteDataSource extends _i1.Mock
    implements _i14.TvSeriesRemoteDataSource {
  MockTvSeriesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i15.TvSeriesModel>> getNowPlayingTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingTvSeries, []),
          returnValue: Future<List<_i15.TvSeriesModel>>.value(
              <_i15.TvSeriesModel>[])) as _i7.Future<List<_i15.TvSeriesModel>>);
  @override
  _i7.Future<List<_i15.TvSeriesModel>> getPopularTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvSeries, []),
          returnValue: Future<List<_i15.TvSeriesModel>>.value(
              <_i15.TvSeriesModel>[])) as _i7.Future<List<_i15.TvSeriesModel>>);
  @override
  _i7.Future<List<_i15.TvSeriesModel>> getTopRatedTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvSeries, []),
          returnValue: Future<List<_i15.TvSeriesModel>>.value(
              <_i15.TvSeriesModel>[])) as _i7.Future<List<_i15.TvSeriesModel>>);
  @override
  _i7.Future<_i3.TvSeriesDetailModel> getTvSeriesDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSeriesDetail, [id]),
              returnValue: Future<_i3.TvSeriesDetailModel>.value(
                  _FakeTvSeriesDetailModel_1()))
          as _i7.Future<_i3.TvSeriesDetailModel>);
  @override
  _i7.Future<List<_i15.TvSeriesModel>> getTvSeriesRecommendation(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSeriesRecommendation, [id]),
          returnValue: Future<List<_i15.TvSeriesModel>>.value(
              <_i15.TvSeriesModel>[])) as _i7.Future<List<_i15.TvSeriesModel>>);
  @override
  _i7.Future<List<_i15.TvSeriesModel>> searchTvSeries(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvSeries, [query]),
          returnValue: Future<List<_i15.TvSeriesModel>>.value(
              <_i15.TvSeriesModel>[])) as _i7.Future<List<_i15.TvSeriesModel>>);
}

/// A class which mocks [TvSeriesLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesLocalDataSource extends _i1.Mock
    implements _i16.TvSeriesLocalDataSource {
  MockTvSeriesLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> saveWatchlist(_i15.TvSeriesModel? tvSeriesModel) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [tvSeriesModel]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlist(_i15.TvSeriesModel? tvSeriesModel) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tvSeriesModel]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i15.TvSeriesModel?> getWatchlistStatus(int? id) =>
      (super.noSuchMethod(Invocation.method(#getWatchlistStatus, [id]),
              returnValue: Future<_i15.TvSeriesModel?>.value())
          as _i7.Future<_i15.TvSeriesModel?>);
  @override
  _i7.Future<List<_i15.TvSeriesModel>> getAllWatchlistTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getAllWatchlistTvSeries, []),
          returnValue: Future<List<_i15.TvSeriesModel>>.value(
              <_i15.TvSeriesModel>[])) as _i7.Future<List<_i15.TvSeriesModel>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i17.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i18.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  Future<List<_i18.MovieModel>>.value(<_i18.MovieModel>[]))
          as _i7.Future<List<_i18.MovieModel>>);
  @override
  _i7.Future<List<_i18.MovieModel>> getPopularMovies() => (super.noSuchMethod(
          Invocation.method(#getPopularMovies, []),
          returnValue: Future<List<_i18.MovieModel>>.value(<_i18.MovieModel>[]))
      as _i7.Future<List<_i18.MovieModel>>);
  @override
  _i7.Future<List<_i18.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
          Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<List<_i18.MovieModel>>.value(<_i18.MovieModel>[]))
      as _i7.Future<List<_i18.MovieModel>>);
  @override
  _i7.Future<_i4.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue: Future<_i4.MovieDetailResponse>.value(
                  _FakeMovieDetailResponse_2()))
          as _i7.Future<_i4.MovieDetailResponse>);
  @override
  _i7.Future<List<_i18.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  Future<List<_i18.MovieModel>>.value(<_i18.MovieModel>[]))
          as _i7.Future<List<_i18.MovieModel>>);
  @override
  _i7.Future<List<_i18.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  Future<List<_i18.MovieModel>>.value(<_i18.MovieModel>[]))
          as _i7.Future<List<_i18.MovieModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i19.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlist(_i20.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlist(_i20.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i20.MovieTable?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<_i20.MovieTable?>.value())
          as _i7.Future<_i20.MovieTable?>);
  @override
  _i7.Future<List<_i20.MovieTable>> getWatchlistMovies() => (super.noSuchMethod(
          Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<List<_i20.MovieTable>>.value(<_i20.MovieTable>[]))
      as _i7.Future<List<_i20.MovieTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i21.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i22.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<_i22.Database?>.value())
          as _i7.Future<_i22.Database?>);
  @override
  _i7.Future<int> insertWatchlist(_i20.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> removeWatchlist(_i20.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<int> saveTvSeriesWatchlist(_i15.TvSeriesModel? tvSeriesModel) =>
      (super.noSuchMethod(
          Invocation.method(#saveTvSeriesWatchlist, [tvSeriesModel]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> removeTvSeriesWatchlist(_i15.TvSeriesModel? tvSeriesModel) =>
      (super.noSuchMethod(
          Invocation.method(#removeTvSeriesWatchlist, [tvSeriesModel]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getTvSeriesWatchlistStatus(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSeriesWatchlistStatus, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getAllWatchlistTVSeries() =>
      (super.noSuchMethod(Invocation.method(#getAllWatchlistTVSeries, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i5.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i5.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i23.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i23.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i23.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i23.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i24.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i24.Uint8List>.value(_i24.Uint8List(0)))
          as _i7.Future<_i24.Uint8List>);
  @override
  _i7.Future<_i5.StreamedResponse> send(_i5.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i5.StreamedResponse>.value(_FakeStreamedResponse_4()))
          as _i7.Future<_i5.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}
