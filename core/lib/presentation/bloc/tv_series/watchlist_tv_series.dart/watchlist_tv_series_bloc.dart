import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvSeriesBloc(this.getWatchlistTvSeries)
      : super(WatchlistTvSeriesInitial()) {
    on<WatchlistTvSeriesEvent>((event, emit) async {
      emit(const WatchlistTvSeriesLoading());
      final result = await getWatchlistTvSeries.execute();
      result.fold((fail) {
        emit(WatchlistTvSeriesError(fail.message));
      }, (data) {
        emit(WatchlistTvSeriesHasData(data));
      });
    });
  }
}
