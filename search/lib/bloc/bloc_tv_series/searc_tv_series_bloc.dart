import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/bloc/bloc_movie/search_bloc.dart';
import 'package:search/domain/usecase/search_tv_series.dart';

part 'searc_tv_series_event.dart';
part 'searc_tv_series_state.dart';

class SearchTvSeriesBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final SearchTvSeries _searchTvSeries;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  SearchTvSeriesBloc(this._searchTvSeries) : super(SearchTvSeriesEmpty()) {
    on<OnQueryChangedTvSeries>(((event, emit) async {
      final query = event.query;

      emit(SearchTvSeriesLoading());
      final result = await _searchTvSeries.execute(query);
      result.fold((failure) {
        emit(SearchTvSeriesError(failure.message));
      }, (data) {
        emit(SearchTvSeriesHasData(data));
      });
    }), transformer: debounce(const Duration(milliseconds: 500)));
  }
}
