import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  var _nowPlayingTvSeries = <TvSeries>[];
  List<TvSeries> get nowPlayingTvSeries => _nowPlayingTvSeries;
  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTvSeries = <TvSeries>[];
  List<TvSeries> get popularTvSeries => _popularTvSeries;
  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  var _topRatedTvSeries = <TvSeries>[];
  List<TvSeries> get topRatedTvSeries => _topRatedTvSeries;
  RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

  String _message = '';
  String get message => _message;

  TvSeriesListNotifier(
      {required this.getNowPlayingTvSeries,
      required this.getPopularTvSeries,
      required this.getTopRatedTvSeries});

  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  Future<void> fetchNowPlayingTvSeries() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvSeries.execute();
    result.fold(_nowPlayingTvSeriesListFailureCallback,
        _nowPlayingTvSeriesListResultCallback);
  }

  Future<void> fetchTopRatedTvSeries() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.execute();
    result.fold(
        _topRatedTvSeriesFailureCallback, _topRatedTvSeriesResultCallback);
  }

  Future<void> fetchPopularTvSeries() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvSeries.execute();
    result.fold(
        _popularTvSeriesFailureCallback, _popularTvSeriesListResultCallback);
  }

  void _nowPlayingTvSeriesListResultCallback(List<TvSeries> tvSeriesList) {
    if (tvSeriesList.isEmpty) {
      _nowPlayingState = RequestState.Empty;
      notifyListeners();
    } else {
      _nowPlayingState = RequestState.Loaded;
      _nowPlayingTvSeries = tvSeriesList;
      notifyListeners();
    }
  }

  void _nowPlayingTvSeriesListFailureCallback(Failure failure) {
    _nowPlayingState = RequestState.Error;
    _message = failure.message;
    notifyListeners();
  }

  void _popularTvSeriesListResultCallback(List<TvSeries> tvSeriesList) {
    if (tvSeriesList.isEmpty) {
      _popularState = RequestState.Empty;
      notifyListeners();
    } else {
      _popularState = RequestState.Loaded;
      _popularTvSeries = tvSeriesList;
      notifyListeners();
    }
  }

  void _popularTvSeriesFailureCallback(Failure failure) {
    _popularState = RequestState.Error;
    _message = failure.message;
    notifyListeners();
  }

  void _topRatedTvSeriesResultCallback(List<TvSeries> tvSeriesList) {
    if (tvSeriesList.isEmpty) {
      _topRatedState = RequestState.Empty;
      notifyListeners();
    } else {
      _topRatedState = RequestState.Loaded;
      _topRatedTvSeries = tvSeriesList;
      notifyListeners();
    }
  }

  void _topRatedTvSeriesFailureCallback(Failure failure) {
    _topRatedState = RequestState.Error;
    _message = failure.message;
    notifyListeners();
  }
}
