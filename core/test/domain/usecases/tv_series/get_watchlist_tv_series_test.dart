import 'package:core/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetWatchlistTvSeries(mockTvSeriesRepository);
  });

  test('should get watchlist tv series from repo', () async {
    //arrange
    when(mockTvSeriesRepository.getWatchlistTvSeries())
        .thenAnswer((_) async => Right(testTvSeriesList));
    //act
    final result = await usecase.execute();
    //assert
    expect(result, Right(testTvSeriesList));
  });

  test('should get an error when error occured', () async {
    //arrange
    when(mockTvSeriesRepository.getWatchlistTvSeries())
        .thenAnswer((_) async => Left(ServerFailure('Error')));
    //act
    final result = await usecase.execute();
    //assert
    expect(result, Left(ServerFailure('Error')));
  });
}
