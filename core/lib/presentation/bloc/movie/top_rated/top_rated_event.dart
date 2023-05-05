part of 'top_rated_bloc.dart';

abstract class TopRatedEvent extends Equatable {
  const TopRatedEvent();

  @override
  List<Object> get props => [];
}

class LoadTopRatedMovie extends TopRatedEvent {
  const LoadTopRatedMovie();

  @override
  List<Object> get props => [];
}
