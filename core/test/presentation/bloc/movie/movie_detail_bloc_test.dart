import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/movie/get_movie_detail.dart';
import 'package:core/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movie/get_watchlist_status.dart';
import 'package:core/domain/usecases/movie/remove_watchlist.dart';
import 'package:core/domain/usecases/movie/save_watchlist.dart';
import 'package:core/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
  });

  test('initial state should be empty', () {
    expect(movieDetailBloc.state, MovieDetailEmpty());
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
      'should emits [Loading, HasData] when get movie detail is success.',
      build: () {
        when(mockGetMovieDetail.execute(2))
            .thenAnswer((_) async => Right(testMovieDetail));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(callMovieDetailById(2)),
      expect: () => [MovieDetailLoading(), MovieDetailHasData(testMovieDetail)],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(2));
      });
  blocTest<MovieDetailBloc, MovieDetailState>(
      'should emits [Loading, Error] when ghet movie is unsuccessful.',
      build: () {
        when(mockGetMovieDetail.execute(2))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(callMovieDetailById(2)),
      expect: () => [MovieDetailLoading(), MovieDetailError('Server Failure')],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(2));
      });
}
