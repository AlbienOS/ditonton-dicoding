part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlistMovie extends WatchlistMovieEvent {
  const LoadWatchlistMovie();

  @override
  List<Object> get props => [];
}
