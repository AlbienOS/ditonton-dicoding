import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:core/presentation/bloc/movie/top_rated/top_rated_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_movie_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedBloc topRatedBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedBloc = TopRatedBloc(mockGetTopRatedMovies);
  });

  blocTest<TopRatedBloc, TopRatedState>('should return initial state',
      build: () => topRatedBloc,
      verify: (bloc) {
        expect(topRatedBloc.state, TopRatedInitial());
      });

  blocTest<TopRatedBloc, TopRatedState>(
    'should return emits [Loading, HasData] when usecase is success.',
    setUp: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
    },
    build: () => topRatedBloc,
    act: (bloc) => bloc.add(const LoadTopRatedMovie()),
    expect: () => [const TopRatedLoading(), TopRatedHasData(testMovieList)],
  );

  blocTest<TopRatedBloc, TopRatedState>(
    'should return emits [Loading, Error] when use case is unsuccessful.',
    setUp: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('')));
    },
    build: () => topRatedBloc,
    act: (bloc) => bloc.add(const LoadTopRatedMovie()),
    expect: () => [TopRatedLoading(), TopRatedError('')],
  );
}
