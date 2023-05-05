part of 'tv_series_recommendation_bloc.dart';

abstract class TvSeriesRecommendationEvent extends Equatable {
  const TvSeriesRecommendationEvent();

  @override
  List<Object> get props => [];
}

class CallTvSeriesRecommendationById extends TvSeriesRecommendationEvent {
  final int tvId;

  CallTvSeriesRecommendationById(this.tvId);

  @override
  List<Object> get props => [tvId];
}
