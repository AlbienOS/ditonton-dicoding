import 'package:core/domain/entities/tv_series.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:search/domain/usecase/search_tv_series.dart';

class TvSeriesSearchNotifier extends ChangeNotifier {
  final SearchTvSeries searchTvSeries;

  TvSeriesSearchNotifier({required this.searchTvSeries});

  List<TvSeries> _searchTvSeriesResult = [];
  List<TvSeries> get searchTvSeriesResult => _searchTvSeriesResult;

  RequestState _searchState = RequestState.Empty;
  RequestState get searchState => _searchState;

  String _message = '';
  String get message => _message;

  Future<void> fetchSearchTvSeries(String query) async {
    _searchState = RequestState.Loading;
    notifyListeners();

    final result = await searchTvSeries.execute(query);
    result.fold(_searchTvSeriesFailureCallback, _searchTvSeriesResultCallback);
  }

  void _searchTvSeriesResultCallback(List<TvSeries> tvSeriesList) {
    if (tvSeriesList.isEmpty) {
      _searchState = RequestState.Empty;
      notifyListeners();
    } else {
      _searchState = RequestState.Loaded;
      _searchTvSeriesResult = tvSeriesList;
      notifyListeners();
    }
  }

  void _searchTvSeriesFailureCallback(Failure failure) {
    _searchState = RequestState.Error;
    _message = failure.message;
    notifyListeners();
  }
}
