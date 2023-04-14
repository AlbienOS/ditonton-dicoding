import 'package:core/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesDetail usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesDetail(mockTvSeriesRepository);
  });

  final ttvId = 1;
  test('should return a detail data when no error occured', () async {
    //arrange
    when(mockTvSeriesRepository.getTvSeriesDetail(ttvId))
        .thenAnswer((_) async => Right(tTvSeriesDetail));
    //act
    final result = await usecase.execute(ttvId);
    //assert
    expect(result, Right(tTvSeriesDetail));
  });

  test('should return an error when error occured', () async {
    //arrange
    when(mockTvSeriesRepository.getTvSeriesDetail(ttvId))
        .thenAnswer((realInvocation) async => Left(ServerFailure('Error')));
    //act
    final result = await usecase.execute(ttvId);
    //assert
    expect(result, Left(ServerFailure('Error')));
  });
}
