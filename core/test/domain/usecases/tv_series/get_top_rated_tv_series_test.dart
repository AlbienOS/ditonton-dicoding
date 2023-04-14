import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTopRatedTvSeries(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];

  group('GetTopRatedTvSeries Tests', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when GetTopRated execute is called',
          () async {
        //arrange
        when(mockTvSeriesRepository.getTopRatedTvSeries())
            .thenAnswer((_) async => Right(tTvSeries));
        //act
        final result = await usecase.execute();
        //assert
        expect(result, Right(tTvSeries));
      });
    });
  });
}
