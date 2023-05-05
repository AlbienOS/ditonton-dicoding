part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistInitial extends MovieWatchlistState {
  @override
  List<Object> get props => [];
}

class MovieWatchlistEmpty extends MovieWatchlistState {}

class MovieWatchlistStatus extends MovieWatchlistState {
  final bool watchlistStatus;

  MovieWatchlistStatus(this.watchlistStatus);

  @override
  List<Object> get props => [watchlistStatus];
}

abstract class MovieRemoveWatchlistState extends MovieWatchlistState {
  final String message;

  const MovieRemoveWatchlistState(this.message);
}

class MovieRemoveWatchlistSuccess extends MovieRemoveWatchlistState {
  MovieRemoveWatchlistSuccess(String message) : super(message);

  @override
  List<Object> get props => [message];
}

class MovieRemoveWatchlistError extends MovieRemoveWatchlistState {
  MovieRemoveWatchlistError(String message) : super(message);

  @override
  List<Object> get props => [message];
}

abstract class MovieInsertWatchlistState extends MovieWatchlistState {
  final String message;

  const MovieInsertWatchlistState(this.message);
}

class MovieInsertWatchlistSuccess extends MovieRemoveWatchlistState {
  MovieInsertWatchlistSuccess(String message) : super(message);

  @override
  List<Object> get props => [message];
}

class MovieInsertWatchlistError extends MovieRemoveWatchlistState {
  MovieInsertWatchlistError(String message) : super(message);

  @override
  List<Object> get props => [message];
}
