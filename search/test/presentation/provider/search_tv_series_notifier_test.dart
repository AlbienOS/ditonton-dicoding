import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecase/search_tv_series.dart';
import 'package:search/presentation/provider/tv_series/tv_series_search_notifier.dart';

import 'search_tv_series_notifier_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late TvSeriesSearchNotifier provider;
  late MockSearchTvSeries mockSearchTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvSeries = MockSearchTvSeries();
    provider = TvSeriesSearchNotifier(searchTvSeries: mockSearchTvSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvSeriesModel = TvSeries(
      id: 2, name: 'name', overview: 'overview', posterPath: 'posterPath');
  final tTvSeriesList = <TvSeries>[tTvSeriesModel];
  final tQuery = 'Money Heist';

  group('Search TV Series', () {
    test('should change state to Loading when usecase is called', () async {
      //arrange
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
      //act
      provider.fetchSearchTvSeries(tQuery);
      //assert
      expect(provider.searchState, RequestState.Loading);
    });

    test('should change state Loaded when data available', () async {
      //arrange
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
      //act
      await provider.fetchSearchTvSeries(tQuery);
      //assert
      expect(provider.searchState, RequestState.Loaded);
      expect(provider.searchTvSeriesResult, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      //arrange
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      //act
      await provider.fetchSearchTvSeries(tQuery);
      //arrange
      expect(provider.searchState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
