part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class callMovieDetailById extends MovieDetailEvent {
  final int id;

  callMovieDetailById(this.id);

  @override
  List<Object> get props => [id];
}
