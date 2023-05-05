import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/movie/get_popular_movies.dart';
import 'package:core/presentation/bloc/movie/popular/popular_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularBloc popularBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularBloc = PopularBloc(mockGetPopularMovies);
  });

  blocTest<PopularBloc, PopularState>('should return intial state',
      build: () => popularBloc,
      verify: (bloc) {
        expect(popularBloc.state, PopularInitial());
      });

  blocTest<PopularBloc, PopularState>(
    'should emits [Loading, HasData] when usecase is Success.',
    setUp: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
    },
    build: () => popularBloc,
    act: (bloc) => bloc.add(const LoadPopularMovie()),
    expect: () => [PopularMovieLoading(), PopularMovieHasData(testMovieList)],
  );
}
