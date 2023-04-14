import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/cupertino.dart';

class PopularTvSeriesNotifier extends ChangeNotifier {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvSeriesNotifier({required this.getPopularTvSeries});

  RequestState _popularTvSeriesState = RequestState.Empty;
  RequestState get popularTvSeriesState => _popularTvSeriesState;

  List<TvSeries> _popularTvSeriesList = [];
  List<TvSeries> get popularTvSeriesList => _popularTvSeriesList;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTvSeries() async {
    _popularTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvSeries.execute();
    result.fold(
        _popularTvSeriesFailureCallback, _popularTvSeriesResultCallback);
  }

  void _popularTvSeriesResultCallback(List<TvSeries> tvSeriesList) {
    if (tvSeriesList.isEmpty) {
      _popularTvSeriesState = RequestState.Empty;
      notifyListeners();
    } else {
      _popularTvSeriesState = RequestState.Loaded;
      _popularTvSeriesList = tvSeriesList;
      notifyListeners();
    }
  }

  void _popularTvSeriesFailureCallback(Failure failure) {
    _popularTvSeriesState = RequestState.Error;
    _message = failure.message;
    notifyListeners();
  }
}
