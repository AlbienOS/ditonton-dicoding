import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:core/presentation/bloc/tv_series/now_playing_tv_series/now_playing_tv_series_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'now_playing_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late NowPlayingTvSeriesBloc nowPlayingTvSeriesBloc;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    nowPlayingTvSeriesBloc = NowPlayingTvSeriesBloc(mockGetNowPlayingTvSeries);
  });

  blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
      'should return Initial State',
      build: () => nowPlayingTvSeriesBloc,
      verify: (bloc) {
        expect(nowPlayingTvSeriesBloc.state, NowPlayingTvSeriesInitial());
      });
  blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
    'should emits [Loading, HasData] when usecase is successful.',
    setUp: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
    },
    build: () => nowPlayingTvSeriesBloc,
    act: (bloc) => bloc.add(const LoadNowPlayingTvSeries()),
    expect: () => [
      const NowPlayingTvSeriesLoading(),
      NowPlayingTvSeriesHasData(testTvSeriesList)
    ],
  );

  blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
    'should emits [Loading, Hasdata] when usecase is unsuccessful.',
    setUp: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('')));
    },
    build: () => nowPlayingTvSeriesBloc,
    act: (bloc) => bloc.add(LoadNowPlayingTvSeries()),
    expect: () => [NowPlayingTvSeriesLoading(), NowPlayingTvSeriesError('')],
  );
}
