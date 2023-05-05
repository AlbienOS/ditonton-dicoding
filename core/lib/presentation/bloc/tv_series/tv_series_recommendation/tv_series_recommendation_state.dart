part of 'tv_series_recommendation_bloc.dart';

abstract class TvSeriesRecommendationState extends Equatable {
  const TvSeriesRecommendationState();

  @override
  List<Object> get props => [];
}

class TvSeriesRecommendationInitial extends TvSeriesRecommendationState {}

class TvSeriesRecommendationLoading extends TvSeriesRecommendationState {
  const TvSeriesRecommendationLoading();

  @override
  List<Object> get props => [];
}

class TvSeriesRecommendationHasData extends TvSeriesRecommendationState {
  final List<TvSeries> tvRecommendationList;

  TvSeriesRecommendationHasData(this.tvRecommendationList);

  @override
  List<Object> get props => [tvRecommendationList];
}

class TvSeriesRecommendationError extends TvSeriesRecommendationState {
  final String message;

  TvSeriesRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}
