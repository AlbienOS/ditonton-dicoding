import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

class TopRatedTvSeriesNotifier extends ChangeNotifier {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesNotifier({required this.getTopRatedTvSeries});

  RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

  List<TvSeries> _topRatedList = [];
  List<TvSeries> get topRatedList => _topRatedList;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvSeries() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.execute();
    result.fold(_topRatedFailureCallback, _topRatedResultCallback);
  }

  void _topRatedResultCallback(List<TvSeries> tvSeriesList) {
    if (tvSeriesList.isEmpty) {
      _topRatedState = RequestState.Empty;
      notifyListeners();
    } else {
      _topRatedState = RequestState.Loaded;
      _topRatedList = tvSeriesList;
      notifyListeners();
    }
  }

  void _topRatedFailureCallback(Failure failure) {
    _topRatedState = RequestState.Error;
    _message = failure.message;
    notifyListeners();
  }
}
