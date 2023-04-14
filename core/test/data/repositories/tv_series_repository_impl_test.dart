import 'dart:io';

import 'package:core/data/models/movie/genre_model.dart';
import 'package:core/data/models/tv_series/tv_series_detail_model.dart';
import 'package:core/data/models/tv_series/tv_series_model.dart';
import 'package:core/data/repositories/tv_series_repository_impl.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesLocalDataSource mockTvSeriesLocalDataSource;
  late MockTvSeriesRemoteDataSource mockTvSeriesRemoteDataSource;

  setUp(() {
    mockTvSeriesRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockTvSeriesLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
        remoteDataSource: mockTvSeriesRemoteDataSource,
        localDataSource: mockTvSeriesLocalDataSource);
  });

  final ttvSeriesModel = TvSeriesModel(
      id: 26,
      name: 'TvSeries Name',
      overview: 'Overview',
      posterPath: 'poster.jpg');

  final ttvSeries = TvSeries(
      id: 26,
      name: 'TvSeries Name',
      overview: 'Overview',
      posterPath: 'poster.jpg');

  final ttvSeriesModelList = <TvSeriesModel>[ttvSeriesModel];
  final ttvSeriesList = <TvSeries>[ttvSeries];

  group('Now Playing Tv Series', () {
    test(
        'should return remote data when the call to remote data source is success',
        () async {
      //arrange
      when(mockTvSeriesRemoteDataSource.getNowPlayingTvSeries())
          .thenAnswer((_) async => ttvSeriesModelList);
      //act
      final result = await repository.getNowPlayingTvSeries();
      //assert
      verify(mockTvSeriesRemoteDataSource.getNowPlayingTvSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, ttvSeriesList);
    });

    test(
        'should throw server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockTvSeriesRemoteDataSource.getNowPlayingTvSeries())
          .thenThrow(ServerException());
      //act
      final result = await repository.getNowPlayingTvSeries();
      //assert
      verify(mockTvSeriesRemoteDataSource.getNowPlayingTvSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should thrpw connection failure when device not connect internet',
        () async {
      //arrange
      when(mockTvSeriesRemoteDataSource.getNowPlayingTvSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      //act
      final result = await repository.getNowPlayingTvSeries();
      //assert
      verify(mockTvSeriesRemoteDataSource.getNowPlayingTvSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Tv Series', () {
    test('should return TvSeries list when call to data source is success',
        () async {
      //arrange
      when(mockTvSeriesRemoteDataSource.getPopularTvSeries())
          .thenAnswer((_) async => ttvSeriesModelList);
      //act
      final result = await repository.getPopularTvSeries();
      //assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, ttvSeriesList);
    });

    test(
        'should throw server failure when the call to datasource is unsuccessful',
        () async {
      //arrange
      when(mockTvSeriesRemoteDataSource.getPopularTvSeries())
          .thenThrow(ServerException());
      //act
      final result = await repository.getPopularTvSeries();
      //assert
      expect(result, Left(ServerFailure('')));
    });
    test(
        'should return connection failure when device is not connected to internet',
        () async {
      //arrange
      when(mockTvSeriesRemoteDataSource.getPopularTvSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      //act
      final result = await repository.getPopularTvSeries();
      //assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated TvSeries', () {
    test('should return TvSeries list when call to datasource is successful',
        () async {
      //arrange
      when(mockTvSeriesRemoteDataSource.getTopRatedTvSeries())
          .thenAnswer((_) async => ttvSeriesModelList);
      //act
      final result = await repository.getTopRatedTvSeries();
      //assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, ttvSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      //arrange
      when(mockTvSeriesRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(ServerException());
      //act
      final result = await repository.getTopRatedTvSeries();
      //assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should throw Connection Failure when device is no connected to the network',
        () async {
      //arrange
      when(mockTvSeriesRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      //act
      final result = await repository.getTopRatedTvSeries();
      //assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get TvSeries Detail', () {
    final tvId = 1;
    final ttvSeriesResponse = TvSeriesDetailModel(
      id: 2,
      genres: [
        GenreModel(id: 1, name: "name1"),
        GenreModel(id: 2, name: "name2")
      ],
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
      numberOfSeasons: 1,
    );
    // test(
    //     'should return TvSeries data when the call to remote data source is successful',
    //     () async {
    //   //arrange
    //   when(mockTvSeriesRemoteDataSource.getTvSeriesDetail(tvId))
    //       .thenAnswer((_) async => ttvSeriesResponse);
    //   //act
    //   final result = await repository.getTvSeriesDetail(tvId);
    //   //
    //   verify(mockTvSeriesRemoteDataSource.getTvSeriesDetail(tvId));
    //   expect(result.isRight(), true);
    // });

    test(
        'should throw ServerFailure when the call to remote data source is unsuccessful',
        () async {
      when(mockTvSeriesRemoteDataSource.getTvSeriesDetail(tvId))
          .thenThrow(Left(ServerException));
    });

    test(
        'should throw Connection Failure when the device is not connected to the network',
        () async {
      //arrange
      when(mockTvSeriesRemoteDataSource.getTvSeriesDetail(tvId))
          .thenThrow(SocketException('Failed to connect to the network'));
      //act
      final result = await repository.getTvSeriesDetail(tvId);
      //arrange
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TvSeries Recommendations', () {
    final tTvSeriesList = <TvSeriesModel>[];
    final tvId = 1;

    test(
        'should return data TvSeries list when the call to remote datasource is successful',
        () async {
      //arrange
      when(mockTvSeriesRemoteDataSource.getTvSeriesRecommendation(tvId))
          .thenAnswer((_) async => tTvSeriesList);
      //act
      final result = await repository.getTvSeriesRecommendation(tvId);
      //assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvSeriesList));
    });

    test(
        'should throw ServerFailure when call to remote datasource is unsuccessful',
        () async {
      //arrange
      when(mockTvSeriesRemoteDataSource.getTvSeriesRecommendation(tvId))
          .thenThrow(ServerException());
      //act
      final result = await repository.getTvSeriesRecommendation(tvId);
      //assert
      verify(mockTvSeriesRemoteDataSource.getTvSeriesRecommendation(tvId));
      expect(result, equals(Left(ServerFailure(''))));
    });
  });

  group('Search Tv Series', () {
    final tQuery = 'Harry Potter';
    test('should return TvSeries list when call to data source is successful',
        () async {
      //arrange
      when(mockTvSeriesRemoteDataSource.searchTvSeries(tQuery))
          .thenAnswer((_) async => ttvSeriesModelList);
      //act
      final result = await repository.searchTvSeries(tQuery);
      //assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, ttvSeriesList);
    });

    test('should throw ServerFailure when call to data source is unsuccessful',
        () async {
      //arrange
      when(mockTvSeriesRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(ServerException());
      //act
      final result = await repository.searchTvSeries(tQuery);
      //assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should throw Connection Failure when device cannot connect to the network',
        () async {
      //arrange
      when(mockTvSeriesRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      //act
      final result = await repository.searchTvSeries(tQuery);
      //assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Save Watchlist', () {
    test('should return success message when saving data is success', () async {
      //arrange
      when(mockTvSeriesLocalDataSource.saveWatchlist(ttvSeriesModels))
          .thenAnswer((_) async => 'Saved to Watchlist');
      //act
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      //assert
      expect(result, Right('Saved to Watchlist'));
    });

    test('should throw DatabaseFailure when saving unsuccessful ', () async {
      //arrange
      when(mockTvSeriesLocalDataSource.saveWatchlist(ttvSeriesModels))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      //act
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      //assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove Watchlist', () {
    test('should return success message when remove data is successful',
        () async {
      //arrange
      when(mockTvSeriesLocalDataSource.removeWatchlist(ttvSeriesModels))
          .thenAnswer((_) async => 'Removed from watchlist');
      //act
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      //arrange
      expect(result, Right('Removed from watchlist'));
    });

    test('should throw DatabaseFailure when removing data is unsuccessful',
        () async {
      //arrange
      when(mockTvSeriesLocalDataSource.removeWatchlist(ttvSeriesModels))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      //act
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      //assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('Get Watchlist Status', () {
    final tvId = 1;
    test('should return watch status whether data is found', () async {
      //arrange
      when(mockTvSeriesLocalDataSource.getWatchlistStatus(tvId))
          .thenAnswer((_) async => null);
      //act
      final result = await repository.getWatchlistStatus(tvId);
      //assert
      expect(result, Right(false));
    });
  });

  group('Get Watchlist TvSeries', () {
    test('should return list watchlist of TvSeries', () async {
      //arrange
      when(mockTvSeriesLocalDataSource.getAllWatchlistTvSeries())
          .thenAnswer((_) async => [ttvSeriesModels]);
      //act
      final result = await repository.getWatchlistTvSeries();
      //assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvSeries]);
    });
  });
}
