import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/movie/get_now_playing_movies.dart';

import 'package:core/presentation/bloc/movie/now_playing/now_playing_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'now_playing_movie_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late NowPlayingBloc nowPlayingBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingBloc = NowPlayingBloc(mockGetNowPlayingMovies);
  });

  blocTest<NowPlayingBloc, NowPlayingState>('initial state should be initial',
      build: () => nowPlayingBloc,
      verify: (bloc) {
        expect(nowPlayingBloc.state, NowPlayingInitial());
      });

  blocTest<NowPlayingBloc, NowPlayingState>(
    'should return emits [Loading, HasData] when get now playing movie is Successful.',
    setUp: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
    },
    build: () => nowPlayingBloc,
    act: (bloc) => bloc.add(const LoadNowPlayingEvent()),
    expect: () =>
        [const NowPlayingMovieLoading(), NowPlayingMovieHasData(testMovieList)],
  );

  blocTest<NowPlayingBloc, NowPlayingState>(
    'should emits [Loading, Error] when get data from usecase is unsuccessful .',
    setUp: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('')));
    },
    build: () => nowPlayingBloc,
    act: (bloc) => bloc.add(const LoadNowPlayingEvent()),
    expect: () => [const NowPlayingMovieLoading(), NowPlayingMovieError('')],
  );
}
