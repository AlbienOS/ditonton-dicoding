import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/cupertino.dart';

class WatchlistTvSeriesNotifier extends ChangeNotifier {
  var _watchlistTvSeries = <TvSeries>[];
  List<TvSeries> get watchlistTvSeries => _watchlistTvSeries;

  var _watchlistTvSeriesState = RequestState.Empty;
  RequestState get watchlistTvSeriesState => _watchlistTvSeriesState;

  String _message = '';
  String get message => _message;

  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvSeriesNotifier({required this.getWatchlistTvSeries});

  Future<void> fetchWatchlistTvSeries() async {
    _watchlistTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvSeries.execute();
    result.fold(
        _watchlistTvSeriesFailureCallback, _watchlistTvSeriesResultCallback);
  }

  void _watchlistTvSeriesResultCallback(List<TvSeries> tvSeriesList) {
    if (tvSeriesList.isEmpty) {
      _watchlistTvSeriesState = RequestState.Empty;
      notifyListeners();
    } else {
      _watchlistTvSeriesState = RequestState.Loaded;
      _watchlistTvSeries = tvSeriesList;
      notifyListeners();
    }
  }

  void _watchlistTvSeriesFailureCallback(Failure failure) {
    _watchlistTvSeriesState = RequestState.Error;
    _message = failure.message;
    notifyListeners();
  }
}
