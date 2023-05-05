import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:core/presentation/bloc/tv_series/watchlist_tv_series.dart/watchlist_tv_series_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_bloc_test.mocks.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    watchlistTvSeriesBloc = WatchlistTvSeriesBloc(mockGetWatchlistTvSeries);
  });

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'should return initialState state',
    build: () => watchlistTvSeriesBloc,
    verify: (bloc) =>
        expect(watchlistTvSeriesBloc.state, WatchlistTvSeriesInitial()),
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'should return emits [Loading, HasData] when usecase is success',
    setUp: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
    },
    build: () => watchlistTvSeriesBloc,
    act: (bloc) => bloc.add(const LoadWatchlistTvSeries()),
    expect: () => [
      const WatchlistTvSeriesLoading(),
      WatchlistTvSeriesHasData(testTvSeriesList)
    ],
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'should return emits [Loading, Error] when usecase is fail.',
    setUp: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    },
    build: () => watchlistTvSeriesBloc,
    act: (bloc) => bloc.add(const LoadWatchlistTvSeries()),
    expect: () => [
      const WatchlistTvSeriesLoading(),
      WatchlistTvSeriesError('Server Failure')
    ],
  );
}
