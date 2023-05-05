import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:core/presentation/bloc/tv_series/popular/popular_tv_series_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late PopularTvSeriesBloc popularTvSeriesBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvSeriesBloc = PopularTvSeriesBloc(mockGetPopularTvSeries);
  });

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'should return state initstate',
      build: () => popularTvSeriesBloc,
      verify: (bloc) {
        expect(popularTvSeriesBloc.state, PopularTvSeriesInitial());
      });
  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'should emits [Loading, HasData] when usecase is success.',
    setUp: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
    },
    build: () => popularTvSeriesBloc,
    act: (bloc) => bloc.add(const LoadPopularTvSeriesEvent()),
    expect: () => [
      const PopularTvSeriesLoading(),
      PopularTvSeriesHasData(testTvSeriesList)
    ],
  );

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'should emits [Loading, Error] when uscase is failed.',
    setUp: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('')));
    },
    build: () => popularTvSeriesBloc,
    act: (bloc) => bloc.add(const LoadPopularTvSeriesEvent()),
    expect: () => [const PopularTvSeriesLoading(), PopularTvSeriesError('')],
  );
}
