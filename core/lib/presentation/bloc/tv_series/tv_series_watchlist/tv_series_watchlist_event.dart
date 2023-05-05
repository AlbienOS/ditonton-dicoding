part of 'tv_series_watchlist_bloc.dart';

abstract class TvSeriesWatchlistEvent extends Equatable {
  const TvSeriesWatchlistEvent();

  @override
  List<Object> get props => [];
}

class CallWatchlistStatusById extends TvSeriesWatchlistEvent {
  final int statusId;

  CallWatchlistStatusById(this.statusId);

  @override
  List<Object> get props => [statusId];
}

class InsertWatchlistTvSeries extends TvSeriesWatchlistEvent {
  final TvSeriesDetail tvSeriesDetail;

  InsertWatchlistTvSeries(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class DoRemoveWatchlistTvSeries extends TvSeriesWatchlistEvent {
  final TvSeriesDetail tvSeriesDetail;

  DoRemoveWatchlistTvSeries(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}
