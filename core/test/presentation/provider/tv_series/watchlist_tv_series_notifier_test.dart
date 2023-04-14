import 'package:core/core.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:core/presentation/provider/tv_series/watchlist_tv_series_notifier.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_notifier_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTvSeries,
])
void main() {
  late WatchlistTvSeriesNotifier provider;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    provider = WatchlistTvSeriesNotifier(
        getWatchlistTvSeries: mockGetWatchlistTvSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  test('should return state Loading when state is loading to fetch data',
      () async {
    //arrange
    when(mockGetWatchlistTvSeries.execute())
        .thenAnswer((_) async => Right([testWatchlistTvSeries]));
    //act
    provider.fetchWatchlistTvSeries();
    //assert
    expect(provider.watchlistTvSeriesState, RequestState.Loading);
  });

  test('should return empty',
      () => expect(provider.watchlistTvSeriesState, RequestState.Empty));
  test('should return state empty when there is no data founded', () async {
    //arrange
    when(mockGetWatchlistTvSeries.execute()).thenAnswer((_) async => Right([]));
    //act
    await provider.fetchWatchlistTvSeries();
    //assert
    expect(provider.watchlistTvSeriesState, RequestState.Empty);
  });

  test('should return state Loaded when data successfuly loaded', () async {
    //arrange
    when(mockGetWatchlistTvSeries.execute())
        .thenAnswer((_) async => Right([testWatchlistTvSeries]));
    //act
    await provider.fetchWatchlistTvSeries();
    //assert
    expect(provider.watchlistTvSeriesState, RequestState.Loaded);
    expect(provider.watchlistTvSeries, [testWatchlistTvSeries]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    //arrange
    when(mockGetWatchlistTvSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    //act
    await provider.fetchWatchlistTvSeries();
    //assert
    expect(provider.watchlistTvSeriesState, RequestState.Error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
