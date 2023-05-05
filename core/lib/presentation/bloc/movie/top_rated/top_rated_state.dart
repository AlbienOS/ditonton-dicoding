part of 'top_rated_bloc.dart';

abstract class TopRatedState extends Equatable {
  const TopRatedState();

  @override
  List<Object> get props => [];
}

class TopRatedInitial extends TopRatedState {
  @override
  List<Object> get props => [];
}

class TopRatedLoading extends TopRatedState {
  const TopRatedLoading();

  @override
  List<Object> get props => [];
}

class TopRatedHasData extends TopRatedState {
  final List<Movie> topRatedList;

  TopRatedHasData(this.topRatedList);

  @override
  List<Object> get props => [topRatedList];
}

class TopRatedError extends TopRatedState {
  final String message;

  TopRatedError(this.message);

  @override
  List<Object> get props => [message];
}
