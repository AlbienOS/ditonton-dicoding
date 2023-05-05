import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_recommendation.dart';
import 'package:core/presentation/bloc/tv_series/tv_series_recommendation/tv_series_recommendation_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendation])
void main() {
  late TvSeriesRecommendationBloc tvSeriesRecommendationBloc;
  late MockGetTvSeriesRecommendation mockGetTvSeriesRecommendation;

  setUp(() {
    mockGetTvSeriesRecommendation = MockGetTvSeriesRecommendation();
    tvSeriesRecommendationBloc =
        TvSeriesRecommendationBloc(mockGetTvSeriesRecommendation);
  });

  final tTvSeriesRecommendation = TvSeries(
      id: 1, name: 'name', overview: 'overview', posterPath: 'poster_path');

  final tTVSeriesRecommendationList = <TvSeries>[tTvSeriesRecommendation];

  blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
    'should return initialState state',
    build: () => tvSeriesRecommendationBloc,
    verify: (bloc) {
      expect(tvSeriesRecommendationBloc.state, TvSeriesRecommendationInitial());
    },
  );

  blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
    'should emits [Loading, HasData] when usecase recommendation is success.',
    build: () {
      when(mockGetTvSeriesRecommendation.execute(2))
          .thenAnswer((_) async => Right(tTVSeriesRecommendationList));
      return tvSeriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(CallTvSeriesRecommendationById(2)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const TvSeriesRecommendationLoading(),
      TvSeriesRecommendationHasData(tTVSeriesRecommendationList)
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendation.execute(2));
    },
  );

  blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
    'should emits [Loading, Error] when usecase tv recommendation is failed.',
    build: () {
      when(mockGetTvSeriesRecommendation.execute(2))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesRecommendationBloc;
    },
    wait: const Duration(milliseconds: 100),
    act: (bloc) => bloc.add(CallTvSeriesRecommendationById(2)),
    expect: () => [
      const TvSeriesRecommendationLoading(),
      TvSeriesRecommendationError('Server Failure')
    ],
  );
}
