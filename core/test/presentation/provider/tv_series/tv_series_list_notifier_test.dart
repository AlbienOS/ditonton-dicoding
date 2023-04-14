import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:core/presentation/provider/tv_series/tv_series_list.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetPopularTvSeries,
  GetTopRatedTvSeries,
  GetNowPlayingTvSeries,
])
void main() {
  late TvSeriesListNotifier provider;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    provider = TvSeriesListNotifier(
        getNowPlayingTvSeries: mockGetNowPlayingTvSeries,
        getPopularTvSeries: mockGetPopularTvSeries,
        getTopRatedTvSeries: mockGetTopRatedTvSeries)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvSeries = TvSeries(
      id: 1, name: 'name', overview: 'overview', posterPath: 'posterPath');

  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('Now Playing Tv Series', () {
    test('should return Loaded state when data is available', () async {
      //arrange
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      //act
      await provider.fetchNowPlayingTvSeries();
      //assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(listenerCallCount, 2);
      expect(provider.nowPlayingTvSeries, tTvSeriesList);
    });

    test('initialState should be empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should change state to Loading when usecase is called', () {
      //arrange
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      //act
      provider.fetchNowPlayingTvSeries();
      //assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should return error when data is unsuccessful', () async {
      //arrange
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      //act
      await provider.fetchNowPlayingTvSeries();
      //assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, "Server Failure");
      expect(listenerCallCount, 2);
    });
  });

  group('Popular Tv Series', () {
    test('should return state Loaded when data is available', () async {
      //arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      //act
      await provider.fetchPopularTvSeries();
      //assert
      expect(provider.popularState, RequestState.Loaded);
      expect(provider.popularTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('initialState should be empty', () async {
      expect(provider.popularState, RequestState.Empty);
    });

    test('should change Loading state when usecase is called', () {
      //arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      //act
      provider.fetchPopularTvSeries();
      //assert
      expect(provider.popularState, RequestState.Loading);
    });

    test('should return error when data is unsuccessful', () async {
      //arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      //act
      await provider.fetchPopularTvSeries();
      //assert
      expect(provider.popularState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Top Rated Tv Series', () {
    test('should return data Loaded when data is available', () async {
      //arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      //act
      await provider.fetchTopRatedTvSeries();
      //assert
      expect(provider.topRatedState, RequestState.Loaded);
      expect(provider.topRatedTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('initialState should be Empty', () {
      expect(provider.topRatedState, RequestState.Empty);
    });

    test('should change Loading state when usecase is called', () {
      //arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      //act
      provider.fetchTopRatedTvSeries();
      //asser
      expect(provider.topRatedState, RequestState.Loading);
    });

    test('should return error when data is unsuccessful', () async {
      //arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      //act
      await provider.fetchTopRatedTvSeries();
      //assert
      expect(provider.topRatedState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
