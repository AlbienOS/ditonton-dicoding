import 'package:core/core.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_recommendation.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_status_tv_series.dart';
import 'package:core/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:core/domain/usecases/tv_series/save_watchlist_tv_series.dart';
import 'package:core/presentation/provider/tv_series/tv_series_detail_notifier.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendation,
  GetWatchlistStatusTvSeries,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {
  late TvSeriesDetailNotifier provider;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendation mockGetTvSeriesRecommendation;
  late MockGetWatchlistStatusTvSeries mockGetWatchlistStatusTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendation = MockGetTvSeriesRecommendation();
    mockGetWatchlistStatusTvSeries = MockGetWatchlistStatusTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    provider = TvSeriesDetailNotifier(
        getTvSeriesDetail: mockGetTvSeriesDetail,
        getTvSeriesRecommendations: mockGetTvSeriesRecommendation,
        getWatchlistStatusTvSeries: mockGetWatchlistStatusTvSeries,
        saveWatchlistTvSeries: mockSaveWatchlistTvSeries,
        removeWatchlistTvSeries: mockRemoveWatchlistTvSeries);
  });

  final tvId = 2;
  group('Get Tv Series Detail', () {
    test('should get Tv Series Detail Data when success executed', () async {
      //arrange
      when(mockGetTvSeriesDetail.execute(tvId))
          .thenAnswer((_) async => Right(tTvSeriesDetail));
      when(mockGetTvSeriesRecommendation.execute(tvId))
          .thenAnswer((_) async => Right(tTvSeriesRecommendation));
      when(mockGetWatchlistStatusTvSeries.execute(tvId))
          .thenAnswer((_) async => Right(false));

      await provider.fetchTvSeriesDetail(tvId);

      expect(provider.tvSeriesDetailState, RequestState.Loaded);
      expect(provider.tvSeriesDetail, tTvSeriesDetail);

      verify(mockGetTvSeriesRecommendation.execute(tvId));
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.tvSeriesRecommendations, tTvSeriesRecommendation);
    });

    test(
        'TvSeriesDetailState should return Error State when fetchTvSeriesDetail return ServerFailure',
        () async {
      //arrange
      when(mockGetTvSeriesDetail.execute(tvId)).thenAnswer(
          (_) async => Left(ServerFailure('Failed to connect to server')));
      when(mockGetTvSeriesRecommendation.execute(tvId))
          .thenAnswer((_) async => Right(tTvSeriesRecommendation));

      //act
      await provider.fetchTvSeriesDetail(tvId);

      //assert
      expect(provider.recommendationState, RequestState.Empty);
      expect(provider.tvSeriesDetailState, RequestState.Error);
      expect(provider.message, 'Failed to connect to server');
    });
  });

  group('Get Watchlist Tv Series', () {
    test('should execute save watchlist tv series', () async {
      //arrange
      when(mockGetTvSeriesDetail.execute(tvId))
          .thenAnswer((_) async => Right(tTvSeriesDetail));
      when(mockGetTvSeriesRecommendation.execute(tvId))
          .thenAnswer((_) async => Right(tTvSeriesRecommendation));

      when(mockGetWatchlistStatusTvSeries.execute(tvId))
          .thenAnswer((_) async => Right(true));
      when(mockSaveWatchlistTvSeries.execute(tTvSeriesDetail))
          .thenAnswer((_) async => Right('Success'));

      //act
      await provider.fetchTvSeriesDetail(tvId);
      await provider.insertToWatchlist(tTvSeriesDetail);
      //assert
      verify(mockGetWatchlistStatusTvSeries.execute(tvId));
      verify(mockGetTvSeriesDetail.execute(tvId));
      expect(provider.addedToWatchlist, true);
    });

    test('should get watchlist status when add watclist success', () async {
      //arrange
      when(mockGetTvSeriesDetail.execute(tvId))
          .thenAnswer((_) async => Right(tTvSeriesDetail));
      when(mockGetTvSeriesRecommendation.execute(tvId))
          .thenAnswer((_) async => Right(tTvSeriesRecommendation));
      when(mockGetWatchlistStatusTvSeries.execute(tvId))
          .thenAnswer((_) async => Right(false));
      //act
      await provider.fetchTvSeriesDetail(tvId);
      await provider.getWatchlistStatus();
      //assert
      expect(provider.addedToWatchlist, false);
    });

    test('should remove from watchlist', () async {
      //arrange
      when(mockGetTvSeriesDetail.execute(tvId))
          .thenAnswer((_) async => Right(tTvSeriesDetail));
      when(mockGetTvSeriesRecommendation.execute(tvId))
          .thenAnswer((_) async => Right(tTvSeriesRecommendation));

      when(mockGetWatchlistStatusTvSeries.execute(tvId))
          .thenAnswer((_) async => Right(false));
      when(mockRemoveWatchlistTvSeries.execute(tTvSeriesDetail))
          .thenAnswer((_) async => Right('Removed'));
      //act
      await provider.fetchTvSeriesDetail(tvId);
      await provider.removeFromWatchlist(tTvSeriesDetail);
      //assert
      verify(mockRemoveWatchlistTvSeries.execute(tTvSeriesDetail));
      expect(provider.addedToWatchlist, false);
    });
  });
}
