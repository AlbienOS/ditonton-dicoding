import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:core/presentation/provider/tv_series/now_playing_tv_series_notifier.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late NowPlayingTvSeriesNotifier provider;
  late int listernerCallCount;

  setUp(() {
    listernerCallCount = 0;
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    provider = NowPlayingTvSeriesNotifier(
        getNowPlayingTvSeries: mockGetNowPlayingTvSeries)
      ..addListener(() {
        listernerCallCount++;
      });
  });
  final tTvSeries = TvSeries(
      id: 2, name: 'name', overview: 'overview', posterPath: 'posterPath');
  final tTvSeriesList = <TvSeries>[tTvSeries];

  test('should change state to loading when usecase is called', () async {
    //arrange
    when(mockGetNowPlayingTvSeries.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));
    //act
    provider.fetchNowPlayingTvSeries();
    //assert
    expect(provider.nowPlayingState, RequestState.Loading);
    expect(listernerCallCount, 1);
  });

  test('should change state to Loaded when data is loaded', () async {
    //arrange
    when(mockGetNowPlayingTvSeries.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));
    //assert
    await provider.fetchNowPlayingTvSeries();
    //
    expect(provider.nowPlayingState, RequestState.Loaded);
    expect(provider.nowPlayingTvSeriesList, tTvSeriesList);
    expect(listernerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    //arrange
    when(mockGetNowPlayingTvSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    //act
    await provider.fetchNowPlayingTvSeries();
    //assert
    expect(provider.nowPlayingState, RequestState.Error);
    expect(provider.message, 'Server Failure');
    expect(listernerCallCount, 2);
  });
}
