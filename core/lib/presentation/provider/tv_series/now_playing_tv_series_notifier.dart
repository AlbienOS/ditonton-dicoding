import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/failure.dart';

class NowPlayingTvSeriesNotifier extends ChangeNotifier {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  NowPlayingTvSeriesNotifier({required this.getNowPlayingTvSeries});

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  List<TvSeries> _nowPlayingTvSeriesList = [];
  List<TvSeries> get nowPlayingTvSeriesList => _nowPlayingTvSeriesList;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingTvSeries() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvSeries.execute();
    result.fold(_nowPlayingFailureCallback, _nowPlayingResultCallback);
  }

  void _nowPlayingResultCallback(List<TvSeries> tvSeriesList) {
    if (tvSeriesList.isEmpty) {
      _nowPlayingState = RequestState.Empty;
      notifyListeners();
    } else {
      _nowPlayingState = RequestState.Loaded;
      _nowPlayingTvSeriesList = tvSeriesList;
      notifyListeners();
    }
  }

  void _nowPlayingFailureCallback(Failure failure) {
    _nowPlayingState = RequestState.Error;
    _message = failure.message;
    notifyListeners();
  }
}
