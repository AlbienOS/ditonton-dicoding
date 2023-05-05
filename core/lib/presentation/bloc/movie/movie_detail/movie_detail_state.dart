part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail movieDetail;

  MovieDetailHasData(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class MovieDetailError extends MovieDetailState {
  String failureMessage;

  MovieDetailError(this.failureMessage);

  @override
  List<Object> get props => [failureMessage];
}
