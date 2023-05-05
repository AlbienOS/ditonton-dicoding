part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlistStatus extends MovieWatchlistEvent {
  final int movieId;

  LoadWatchlistStatus(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class InsertWatchlist extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  InsertWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class DoRemoveWatchlist extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  DoRemoveWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
