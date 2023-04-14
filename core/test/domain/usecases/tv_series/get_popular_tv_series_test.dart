import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetPopularTvSeries(mockTvSeriesRepository);
  });
  final tTvSeries = <TvSeries>[];

  group('GetPopularTvSeries Test', () {
    group('execute', () {
      test(
          'should get list of TvSeries from the repo when GetPopularTvSeries is called',
          () async {
        //arange
        when(mockTvSeriesRepository.getPopularTvSeries())
            .thenAnswer((_) async => Right(tTvSeries));
        //act
        final result = await usecase.execute();
        //assert
        expect(result, Right(tTvSeries));
      });
    });
  });
}
