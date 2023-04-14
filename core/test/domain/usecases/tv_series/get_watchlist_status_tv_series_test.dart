import 'package:core/domain/usecases/tv_series/get_watchlist_status_tv_series.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistStatusTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetWatchlistStatusTvSeries(mockTvSeriesRepository);
  });
  test('should get watchlist status from repo ', () async {
    //arrange
    when(mockTvSeriesRepository.getWatchlistStatus(1))
        .thenAnswer((realInvocation) async => Right(true));
    //act
    final result = await usecase.execute(1);
    //assert
    expect(result, Right(true));
  });

  test('should get an error when error occured', () async {
    //arrange
    when(mockTvSeriesRepository.getWatchlistStatus(1))
        .thenAnswer((realInvocation) async => Left(DatabaseFailure('Error')));
    //act
    final result = await usecase.execute(1);
    //expect
    expect(result, Left(DatabaseFailure('Error')));
  });
}
