import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/bloc/bloc_movie/search_bloc.dart';
import 'package:search/domain/usecase/search_movies.dart';

import '../../../dummy_data/dummy_object.dart';
import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchBloc searchBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchBloc = SearchBloc(mockSearchMovies);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchEmpty());
  });

  blocTest<SearchBloc, SearchState>(
      'should emit [Loading. HasData] when data is gotten succesfuly',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [SearchLoading(), SearchHasData(tMovieList)],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      });

  blocTest<SearchBloc, SearchState>(
      'should emit[Loading, Error] when data is unsuccessfully',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [SearchLoading(), SearchError('Server Failure')],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      });
}
