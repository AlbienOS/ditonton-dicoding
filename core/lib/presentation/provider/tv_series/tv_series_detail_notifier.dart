import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_status_tv_series.dart';
import 'package:core/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/usecases/tv_series/get_tv_series_recommendation.dart';
import '../../../domain/usecases/tv_series/save_watchlist_tv_series.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  static const tvSeriesWatchlistAddSuccessMessage = 'Added to Watchlist';
  static const tvSeriesWatchlistRemoveSuccessMessage = 'Remove from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendation getTvSeriesRecommendations;
  final GetWatchlistStatusTvSeries getWatchlistStatusTvSeries;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;

  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getWatchlistStatusTvSeries,
    required this.saveWatchlistTvSeries,
    required this.removeWatchlistTvSeries,
  });

  TvSeriesDetail? _tvSeriesDetail;
  TvSeriesDetail? get tvSeriesDetail => _tvSeriesDetail;

  RequestState _tvSeriesDetailState = RequestState.Empty;
  RequestState get tvSeriesDetailState => _tvSeriesDetailState;

  List<TvSeries> _tvSeriesRecommendations = [];
  List<TvSeries> get tvSeriesRecommendations => _tvSeriesRecommendations;

  RequestState _recommendationsState = RequestState.Empty;
  RequestState get recommendationState => _recommendationsState;

  String _message = 'Failed to connect to server';
  String get message => _message;

  bool _addedToWatchlist = false;
  bool get addedToWatchlist => _addedToWatchlist;

  Future<void> fetchTvSeriesDetail(int id) async {
    _tvSeriesDetailState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTvSeriesDetail.execute(id);
    detailResult.fold(
        _tvSeriesDetailFailureCallback, _tvSeriesDetailResultCallback);

    if (_tvSeriesDetailState == RequestState.Error) return;
    _recommendationsState = RequestState.Loading;
    notifyListeners();

    await getWatchlistStatus();

    final recommendationList = await getTvSeriesRecommendations.execute(id);
    recommendationList.fold(_tvSeriesRecommendationsFailureCallback,
        _tvSeriesRecommendationsResultCallback);
  }

  String _tvSeriesWatchlistMesssage = '';
  String get tvSeriesWatchlistMessage => _tvSeriesWatchlistMesssage;

  Future<void> removeFromWatchlist(TvSeriesDetail tvSeriesDetail) async {
    if (_tvSeriesDetail == null) {
      throw Exception('tv series detail haven\'t been fetched');
    }
    final result = await removeWatchlistTvSeries.execute(tvSeriesDetail);
    result.fold((failure) => _tvSeriesWatchlistMesssage = failure.message,
        (success) => _tvSeriesWatchlistMesssage = success);

    getWatchlistStatus();
  }

  Future<void> insertToWatchlist(TvSeriesDetail tvSeriesDetail) async {
    if (_tvSeriesDetail == null) {
      throw Exception('tv series detail haven\'t been fetched');
    }
    await saveWatchlistTvSeries.execute(tvSeriesDetail);
  }

  Future<void> getWatchlistStatus() async {
    if (_tvSeriesDetail == null) {
      throw Exception('Tv Series detail havent been fetched');
    }

    final result = await getWatchlistStatusTvSeries.execute(tvSeriesDetail!.id);

    result.fold((l) => null, (r) {
      _addedToWatchlist = r;
      notifyListeners();
    });
  }

  void _tvSeriesDetailFailureCallback(Failure failure) {
    _tvSeriesDetailState = RequestState.Error;
    notifyListeners();
  }

  void _tvSeriesDetailResultCallback(TvSeriesDetail detail) {
    _tvSeriesDetailState = RequestState.Loaded;
    _tvSeriesDetail = detail;
    notifyListeners();
  }

  void _tvSeriesRecommendationsFailureCallback(Failure failure) {
    _recommendationsState = RequestState.Error;
    notifyListeners();
  }

  void _tvSeriesRecommendationsResultCallback(List<TvSeries> result) {
    if (result.isEmpty) {
      _recommendationsState = RequestState.Empty;
      notifyListeners();
    } else {
      _recommendationsState = RequestState.Loaded;
      _tvSeriesRecommendations = result;
      notifyListeners();
    }
  }
}
