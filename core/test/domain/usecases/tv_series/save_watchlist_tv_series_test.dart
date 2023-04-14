import 'package:core/domain/usecases/tv_series/save_watchlist_tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SaveWatchlistTvSeries(mockTvSeriesRepository);
  });

  test('should save watchlist tv series from repo', () async {
    //arrange
    when(mockTvSeriesRepository.saveWatchlist(tTvSeriesDetail))
        .thenAnswer((realInvocation) async => Right('Saved to watchlist'));
    //act
    final result = await usecase.execute(tTvSeriesDetail);
    //assert
    expect(result, Right('Saved to watchlist'));
  });
}
