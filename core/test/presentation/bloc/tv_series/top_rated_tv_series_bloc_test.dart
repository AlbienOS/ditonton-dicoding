import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:core/presentation/bloc/tv_series/top_rated/top_rated_tv_series_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvSeriesBloc = TopRatedTvSeriesBloc(mockGetTopRatedTvSeries);
  });

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'should return initialState state.',
      build: () => topRatedTvSeriesBloc,
      verify: (bloc) {
        expect(topRatedTvSeriesBloc.state, TopRatedTvSeriesInitial());
      });
  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'should emits [Loading, HasData] when usecase is success.',
    setUp: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
    },
    build: () => topRatedTvSeriesBloc,
    act: (bloc) => bloc.add(const LoadTopRatedTvSeries()),
    expect: () => [
      const TopRatedTvSeriesLoading(),
      TopRatedTvSeriesHasData(testTvSeriesList)
    ],
  );

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'should return emits [Loading, Error] when usecase is fail.',
    setUp: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('')));
    },
    build: () => topRatedTvSeriesBloc,
    act: (bloc) => bloc.add(const LoadTopRatedTvSeries()),
    expect: () => [TopRatedTvSeriesLoading(), TopRatedTvSeriesError('')],
  );
}
