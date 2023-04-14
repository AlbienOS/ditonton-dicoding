import 'package:core/domain/entities/tv_series.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecase/search_tv_series.dart';
import '../../test_helper.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SearchTvSeries(mockTvSeriesRepository);
  });

  final ttvSeries = <TvSeries>[];
  final tQuery = 'Superman';

  test('should get list of tvseries from repository', () async {
    //arrange
    when(mockTvSeriesRepository.searchTvSeries(tQuery))
        .thenAnswer((_) async => Right(ttvSeries));
    //act
    final result = await usecase.execute(tQuery);
    //assert
    expect(result, Right(ttvSeries));
  });

  test('should return a error server failure from repository', () async {
    //arrange
    when(mockTvSeriesRepository.searchTvSeries(tQuery))
        .thenAnswer((_) async => Left(ServerFailure('Error')));
    //act
    final result = await usecase.execute(tQuery);
    //assert
    expect(result, Left(ServerFailure('Error')));
  });
}
