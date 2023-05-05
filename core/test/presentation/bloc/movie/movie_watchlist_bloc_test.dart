import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:core/domain/usecases/movie/get_watchlist_status.dart';
import 'package:core/domain/usecases/movie/remove_watchlist.dart';
import 'package:core/domain/usecases/movie/save_watchlist.dart';
import 'package:core/presentation/bloc/movie/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlist, RemoveWatchlist, GetWatchListStatus])
void main() {
  late MovieWatchlistBloc movieWatchlistBloc;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockGetWatchListStatus mockGetWatchListStatus;

  setUp(() {
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockGetWatchListStatus = MockGetWatchListStatus();
    movieWatchlistBloc = MovieWatchlistBloc(
        insertWatchlist: mockSaveWatchlist,
        removeWatchlist: mockRemoveWatchlist,
        getWatchListStatus: mockGetWatchListStatus);
  });

  final int tId = 103;

  test('initialstate should be Empty', () {
    expect(movieWatchlistBloc.state, MovieWatchlistEmpty());
  });

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'should return false when usecase said false',
    setUp: () {
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => false);
    },
    build: () => movieWatchlistBloc,
    act: (bloc) => bloc.add(LoadWatchlistStatus(tId)),
    expect: () => [MovieWatchlistStatus(false)],
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'should return false when usecase said true',
    setUp: () {
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
    },
    build: () => movieWatchlistBloc,
    act: (bloc) => bloc.add(LoadWatchlistStatus(tId)),
    expect: () => [MovieWatchlistStatus(true)],
  );

  group('save watchlist', () {
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should return success message from usecase',
      setUp: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Right('Successfully added to watchlist'));
      },
      build: () => movieWatchlistBloc,
      act: (bloc) => bloc.add(InsertWatchlist(testMovieDetail)),
      expect: () =>
          [isA<MovieInsertWatchlistSuccess>(), MovieWatchlistStatus(true)],
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should return failure meesage from usecase',
      setUp: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => Left(ServerFailure('Failed added to watchlist')));
      },
      build: () => movieWatchlistBloc,
      act: (bloc) => bloc.add(InsertWatchlist(testMovieDetail)),
      expect: () =>
          [isA<MovieInsertWatchlistError>(), MovieWatchlistStatus(false)],
    );
  });

  group('Remove Watchlist', () {
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should return success message from usecase',
      setUp: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Right('Success to remove from watchlist'));
      },
      build: () => movieWatchlistBloc,
      act: (bloc) => bloc.add(DoRemoveWatchlist(testMovieDetail)),
      expect: () =>
          [isA<MovieRemoveWatchlistSuccess>(), MovieWatchlistStatus(false)],
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should return fail message from usecase',
      setUp: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async =>
                Left(DatabaseFailure('Successfully removed from watchlist')));
      },
      build: () => movieWatchlistBloc,
      act: (bloc) => bloc.add(DoRemoveWatchlist(testMovieDetail)),
      expect: () =>
          [isA<MovieRemoveWatchlistError>(), MovieWatchlistStatus(true)],
    );
  });
}
