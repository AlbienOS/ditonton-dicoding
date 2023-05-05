import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:core/presentation/bloc/movie/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationBloc movieRecommendationBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  const tId = 1;

  final tMovieRecommendation = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'poster_path',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieRecommendationList = <Movie>[tMovieRecommendation];

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationBloc =
        MovieRecommendationBloc(mockGetMovieRecommendations);
  });

  test('should initial emit empty ', () {
    expect(movieRecommendationBloc.state, MovieRecommendationEmpty());
  });

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'should emits [Loading. HasData] when get movie recommendation is success.',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovieRecommendationList));
        return movieRecommendationBloc;
      },
      act: (bloc) => bloc.add(callMovieRecommendationById(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
            MovieRecommendationLoading(),
            MovieRecommendationHasData(tMovieRecommendationList)
          ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      });
  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'should emits [Loading, Error] when get movie recommendation is unsuccessful.',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieRecommendationBloc;
      },
      act: (bloc) => bloc.add(callMovieRecommendationById(tId)),
      expect: () => [
            MovieRecommendationLoading(),
            MovieRecommendationError('Server Failure')
          ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      });
}
