import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(mockGetWatchlistMovies);
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'should return state initialState',
    build: () => watchlistMovieBloc,
    verify: (bloc) => expect(watchlistMovieBloc.state, WatchlistMovieInitial()),
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'should return emits [Loading, HasData] when usecase is success.',
    setUp: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
    },
    build: () => watchlistMovieBloc,
    act: (bloc) => bloc.add(const LoadWatchlistMovie()),
    expect: () =>
        [const WatchlistMovieLoading(), WatchlistMovieHasData(testMovieList)],
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'should return emits [Loading, Error] when usecase is fail.',
    setUp: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    },
    build: () => watchlistMovieBloc,
    act: (bloc) => bloc.add(const LoadWatchlistMovie()),
    expect: () =>
        [const WatchlistMovieLoading(), WatchlistMovieError('Server Failure')],
  );
}
