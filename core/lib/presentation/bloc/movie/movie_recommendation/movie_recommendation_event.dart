part of 'movie_recommendation_bloc.dart';

abstract class MovieRecommendationEvent extends Equatable {
  const MovieRecommendationEvent();

  @override
  List<Object> get props => [];
}

class callMovieRecommendationById extends MovieRecommendationEvent {
  final int id;

  callMovieRecommendationById(this.id);

  @override
  List<Object> get props => [id];
}
