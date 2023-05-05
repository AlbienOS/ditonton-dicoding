part of 'popular_bloc.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}

class PopularInitial extends PopularState {
  @override
  List<Object> get props => [];
}

class PopularMovieLoading extends PopularState {
  const PopularMovieLoading();

  @override
  List<Object> get props => [];
}

class PopularMovieHasData extends PopularState {
  final List<Movie> popularList;

  PopularMovieHasData(this.popularList);

  @override
  List<Object> get props => [popularList];
}

class PopularMovieError extends PopularState {
  final String message;

  PopularMovieError(this.message);

  @override
  List<Object> get props => [message];
}
