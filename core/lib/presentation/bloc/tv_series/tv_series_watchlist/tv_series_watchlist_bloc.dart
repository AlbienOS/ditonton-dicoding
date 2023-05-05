import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_status_tv_series.dart';
import 'package:core/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:core/domain/usecases/tv_series/save_watchlist_tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../utils/failure.dart';

part 'tv_series_watchlist_event.dart';
part 'tv_series_watchlist_state.dart';

class TvSeriesWatchlistBloc
    extends Bloc<TvSeriesWatchlistEvent, TvSeriesWatchlistState> {
  final SaveWatchlistTvSeries insertWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;
  final GetWatchlistStatusTvSeries getWatchlistStatusTvSeries;
  TvSeriesWatchlistBloc(
      {required this.insertWatchlistTvSeries,
      required this.removeWatchlistTvSeries,
      required this.getWatchlistStatusTvSeries})
      : super(TvSeriesWatchlistInitial()) {
    on<CallWatchlistStatusById>((event, emit) async {
      final tvId = event.statusId;
      final result = await getWatchlistStatusTvSeries.execute(tvId);
      emit(TvSeriesWatchlistGetStatus(result));
    });
    on<InsertWatchlistTvSeries>((event, emit) async {
      final tvSeriesDetail = event.tvSeriesDetail;
      final result = await insertWatchlistTvSeries.execute(tvSeriesDetail);
      result.fold((fail) {
        emit(TvSeriesInsertWatchlistError(fail.message));
      }, (message) {
        emit(TvSeriesInsertWatchlistSuccess(message));
      });
      add(CallWatchlistStatusById(event.tvSeriesDetail.id));
    });
    on<DoRemoveWatchlistTvSeries>((event, emit) async {
      final tvSeriesDetail = event.tvSeriesDetail;
      final result = await removeWatchlistTvSeries.execute(tvSeriesDetail);
      result.fold((fail) {
        emit(TvSeriesRemoveWatchlistError(fail.message));
      }, (message) {
        emit(TvSeriesRemoveWatchlistSuccess(message));
      });
      add(CallWatchlistStatusById(event.tvSeriesDetail.id));
    });
  }
}
