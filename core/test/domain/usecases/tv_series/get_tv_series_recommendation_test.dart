import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_recommendation.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendation usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendation(mockTvSeriesRepository);
  });

  final ttvId = 1;
  final ttvSeries = <TvSeries>[];

  test('should get list of TvSeries recommendation tv id from the repository',
      () async {
    //arrange
    when(mockTvSeriesRepository.getTvSeriesRecommendation(ttvId))
        .thenAnswer((_) async => Right(ttvSeries));
    //act
    final result = await usecase.execute(ttvId);
    //
    expect(result, Right(ttvSeries));
  });

  test('should return an error when the condition is failure', () async {
    //arrange
    when(mockTvSeriesRepository.getTvSeriesRecommendation(ttvId))
        .thenAnswer((_) async => Left(ServerFailure('Error')));
    //act
    final result = await usecase.execute(ttvId);
    //assert
    expect(result, Left(ServerFailure('Error')));
  });
}
