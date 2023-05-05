part of 'now_playing_bloc.dart';

abstract class NowPlayingState extends Equatable {
  const NowPlayingState();

  @override
  List<Object> get props => [];
}

class NowPlayingInitial extends NowPlayingState {
  @override
  List<Object> get props => [];
}

class NowPlayingMovieLoading extends NowPlayingState {
  const NowPlayingMovieLoading();

  @override
  List<Object> get props => [];
}

class NowPlayingMovieHasData extends NowPlayingState {
  final List<Movie> movieList;

  NowPlayingMovieHasData(this.movieList);

  @override
  List<Object> get props => [movieList];
}

class NowPlayingMovieError extends NowPlayingState {
  final String errorMessage;

  NowPlayingMovieError(this.errorMessage);

  @override
  List<Object> get props => [];
}
