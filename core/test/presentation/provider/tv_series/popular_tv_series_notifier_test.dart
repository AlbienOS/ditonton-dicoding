import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:core/presentation/provider/tv_series/popular_tv_series_notifier.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late PopularTvSeriesNotifier provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    provider =
        PopularTvSeriesNotifier(getPopularTvSeries: mockGetPopularTvSeries)
          ..addListener(() {
            listenerCallCount++;
          });
  });

  final tTvSeries = TvSeries(
      id: 2, name: 'name', overview: 'overview', posterPath: 'posterPath');
  final tTvSeriesList = <TvSeries>[tTvSeries];

  test('should change state to loading when usecase is called', () async {
    //arrange
    when(mockGetPopularTvSeries.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));
    //act
    provider.fetchPopularTvSeries();
    //assert
    expect(provider.popularTvSeriesState, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change state to Loaded when data is loaded', () async {
    //arrange
    when(mockGetPopularTvSeries.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));
    //act
    await provider.fetchPopularTvSeries();
    //assert
    expect(provider.popularTvSeriesState, RequestState.Loaded);
    expect(provider.popularTvSeriesList, tTvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    //arrange
    when(mockGetPopularTvSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    //act
    await provider.fetchPopularTvSeries();
    //assert
    expect(provider.popularTvSeriesState, RequestState.Error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
