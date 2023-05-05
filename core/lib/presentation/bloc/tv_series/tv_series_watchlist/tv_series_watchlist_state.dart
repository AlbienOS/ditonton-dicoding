part of 'tv_series_watchlist_bloc.dart';

abstract class TvSeriesWatchlistState extends Equatable {
  const TvSeriesWatchlistState();

  @override
  List<Object> get props => [];
}

class TvSeriesWatchlistInitial extends TvSeriesWatchlistState {
  @override
  List<Object> get props => [];
}

class TvSeriesWatchlistEmpty extends TvSeriesWatchlistState {}

class TvSeriesWatchlistGetStatus extends TvSeriesWatchlistState {
  final Either<Failure, bool> watchlistTvSeriesStatus;

  TvSeriesWatchlistGetStatus(this.watchlistTvSeriesStatus);

  @override
  List<Object> get props => [watchlistTvSeriesStatus];
}

abstract class TvSeriesRemoveWatchlistState extends TvSeriesWatchlistState {
  final String message;

  const TvSeriesRemoveWatchlistState(this.message);
}

class TvSeriesRemoveWatchlistSuccess extends TvSeriesRemoveWatchlistState {
  TvSeriesRemoveWatchlistSuccess(String message) : super(message);

  @override
  List<Object> get props => [message];
}

class TvSeriesRemoveWatchlistError extends TvSeriesRemoveWatchlistState {
  TvSeriesRemoveWatchlistError(String message) : super(message);

  @override
  List<Object> get props => [message];
}

abstract class TvSeriesInsertWatchlistState extends TvSeriesWatchlistState {
  final String message;

  const TvSeriesInsertWatchlistState(this.message);
}

class TvSeriesInsertWatchlistSuccess extends TvSeriesInsertWatchlistState {
  TvSeriesInsertWatchlistSuccess(String message) : super(message);

  @override
  List<Object> get props => [message];
}

class TvSeriesInsertWatchlistError extends TvSeriesInsertWatchlistState {
  TvSeriesInsertWatchlistError(String message) : super(message);

  @override
  List<Object> get props => [message];
}
