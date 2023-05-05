import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_status_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:core/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:core/domain/usecases/tv_series/save_watchlist_tv_series.dart';
import 'package:core/presentation/bloc/tv_series/tv_series_watchlist/tv_series_watchlist_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
  GetWatchlistStatusTvSeries
])
void main() {
  late TvSeriesWatchlistBloc tvSeriesWatchlistBloc;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
  late MockGetWatchlistStatusTvSeries mockGetWatchlistStatusTvSeries;

  setUp(() {
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    mockGetWatchlistStatusTvSeries = MockGetWatchlistStatusTvSeries();
    tvSeriesWatchlistBloc = TvSeriesWatchlistBloc(
        insertWatchlistTvSeries: mockSaveWatchlistTvSeries,
        removeWatchlistTvSeries: mockRemoveWatchlistTvSeries,
        getWatchlistStatusTvSeries: mockGetWatchlistStatusTvSeries);
  });

  const int tvId = 103;

  blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
    'should return initState state',
    build: () => tvSeriesWatchlistBloc,
    verify: (bloc) {
      expect(tvSeriesWatchlistBloc.state, TvSeriesWatchlistInitial());
    },
  );

  blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
    'should return false when usecase said false',
    setUp: () {
      when(mockGetWatchlistStatusTvSeries.execute(tvId))
          .thenAnswer((_) async => const Right(false));
    },
    build: () => tvSeriesWatchlistBloc,
    act: (bloc) => bloc.add(CallWatchlistStatusById(tvId)),
    expect: () => [TvSeriesWatchlistGetStatus(const Right(false))],
  );

  blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
    'should return true when usecase said true',
    setUp: () {
      when(mockGetWatchlistStatusTvSeries.execute(tvId))
          .thenAnswer((_) async => const Right(true));
    },
    build: () => tvSeriesWatchlistBloc,
    act: (bloc) => bloc.add(CallWatchlistStatusById(tvId)),
    expect: () => [TvSeriesWatchlistGetStatus(const Right(true))],
  );

  group('Save Watchlist', () {
    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'should return save success message from usecase',
      setUp: () {
        when(mockGetWatchlistStatusTvSeries.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => const Right(true));
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail)).thenAnswer(
            (_) async => const Right('Successfully added to watchlist'));
      },
      build: () => tvSeriesWatchlistBloc,
      act: (bloc) => bloc.add(InsertWatchlistTvSeries(testTvSeriesDetail)),
      expect: () => [
        isA<TvSeriesInsertWatchlistSuccess>(),
        TvSeriesWatchlistGetStatus(const Right(true))
      ],
    );

    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'should return save failure message from usecase',
      setUp: () {
        when(mockGetWatchlistStatusTvSeries.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => const Right(false));
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail)).thenAnswer(
            (_) async => Left(ServerFailure('Failed added to watchlist')));
      },
      build: () => tvSeriesWatchlistBloc,
      act: (bloc) => bloc.add(InsertWatchlistTvSeries(testTvSeriesDetail)),
      expect: () => [
        isA<TvSeriesInsertWatchlistError>(),
        TvSeriesWatchlistGetStatus(const Right(false))
      ],
    );
  });

  group('Remove Watchlist', () {
    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'should return success remove message from usecase',
      setUp: () {
        when(mockGetWatchlistStatusTvSeries.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => const Right(false));
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer(
                (_) async => const Right('Success to remove from watchlist'));
      },
      build: () => tvSeriesWatchlistBloc,
      act: (bloc) => bloc.add(DoRemoveWatchlistTvSeries(testTvSeriesDetail)),
      expect: () => [
        isA<TvSeriesRemoveWatchlistSuccess>(),
        TvSeriesWatchlistGetStatus(const Right(false))
      ],
    );

    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'should return failure remove message from usecase',
      setUp: () {
        when(mockGetWatchlistStatusTvSeries.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => const Right(true));
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async =>
                Left(DatabaseFailure('Successfully removed from watchlist')));
      },
      build: () => tvSeriesWatchlistBloc,
      act: (bloc) => bloc.add(DoRemoveWatchlistTvSeries(testTvSeriesDetail)),
      expect: () => [
        isA<TvSeriesRemoveWatchlistError>(),
        TvSeriesWatchlistGetStatus(const Right(true))
      ],
    );
  });
}
