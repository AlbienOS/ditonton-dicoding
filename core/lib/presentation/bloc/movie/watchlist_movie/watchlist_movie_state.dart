part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WatchlistMovieInitial extends WatchlistMovieState {}

class WatchlistMovieLoading extends WatchlistMovieState {
  const WatchlistMovieLoading();

  @override
  List<Object> get props => [];
}

class WatchlistMovieHasData extends WatchlistMovieState {
  final List<Movie> watchlistMovie;

  WatchlistMovieHasData(this.watchlistMovie);

  @override
  List<Object> get props => [watchlistMovie];
}

class WatchlistMovieError extends WatchlistMovieState {
  final String message;

  WatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}
