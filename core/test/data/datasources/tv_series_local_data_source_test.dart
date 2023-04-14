import 'package:core/data/datasources/tv_series_local_data_source.dart';
import 'package:core/data/models/tv_series/tv_series_model.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvSeriesDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  final ttvSeriesModel = TvSeriesModel(
    posterPath: "/aurZJ8UsXqhGwwBnNuZsPNepY8y.jpg",
    id: 64122,
    name: "The Shannara Chronicles",
    overview:
        "A young Healer armed with an unpredictable magic guides a runaway Elf in her perilous quest to save the peoples of the Four Lands from an age-old Demon scourge.",
  );

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      //arrange
      when(mockDatabaseHelper.saveTvSeriesWatchlist(ttvSeriesModel))
          .thenAnswer((_) async => 1);
      //act
      final result = await dataSource.saveWatchlist(ttvSeriesModel);
      //assert
      expect(result, 'Saved to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      //arrange
      when(mockDatabaseHelper.saveTvSeriesWatchlist(ttvSeriesModel))
          .thenThrow(Exception());
      //act
      final call = dataSource.saveWatchlist(ttvSeriesModel);
      //assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test(
        'should return a success message when remove from from database is success',
        () async {
      //arrange
      when(mockDatabaseHelper.removeTvSeriesWatchlist(ttvSeriesModel))
          .thenAnswer((_) async => 1);
      //act
      final result = await dataSource.removeWatchlist(ttvSeriesModel);
      //assert
      expect(result, 'Removed from Watchlist');
    });
    test(
        'should return throw DatabaseException when remove from database is failed',
        () async {
      //arrange
      when(mockDatabaseHelper.removeTvSeriesWatchlist(ttvSeriesModel))
          .thenThrow(Exception());
      //act
      final call = dataSource.removeWatchlist(ttvSeriesModel);
      //arrange
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie Detail by Id', () {
    final ttvId = 1;
    test('should return TvSeries Detail Table when data is found', () async {
      //arrange
      when(mockDatabaseHelper.getTvSeriesWatchlistStatus(ttvId))
          .thenAnswer((_) async => testTvSeries);
      //act
      final result = await dataSource.getWatchlistStatus(ttvId);
      //asser
      expect(result, ttvSeriesModel);
    });

    test('should return null whn data not found', () async {
      //arrange
      when(mockDatabaseHelper.getTvSeriesWatchlistStatus(ttvId))
          .thenAnswer((_) async => null);
      //act
      final result = await dataSource.getWatchlistStatus(ttvId);
      //assert
      expect(result, null);
    });

    group('get watchlist tvseries', () {
      test('should return list of TvSeriesModel from database', () async {
        //arrange
        when(mockDatabaseHelper.getAllWatchlistTVSeries())
            .thenAnswer((_) async => [testTvSeries]);
        //act
        final result = await dataSource.getAllWatchlistTvSeries();
        //assert
        expect(result, [ttvSeriesModel]);
      });

      test('should return empty list when there is not found wathlist',
          () async {
        //arrange
        when(mockDatabaseHelper.getAllWatchlistTVSeries())
            .thenAnswer((_) async => []);
        //act
        final result = await dataSource.getAllWatchlistTvSeries();
        //assert
        expect(result, []);
      });
    });
  });
}
