part of 'top_rated_tv_series_bloc.dart';

abstract class TopRatedTvSeriesState extends Equatable {
  const TopRatedTvSeriesState();

  @override
  List<Object> get props => [];
}

class TopRatedTvSeriesInitial extends TopRatedTvSeriesState {}

class TopRatedTvSeriesLoading extends TopRatedTvSeriesState {
  const TopRatedTvSeriesLoading();

  @override
  List<Object> get props => [];
}

class TopRatedTvSeriesHasData extends TopRatedTvSeriesState {
  final List<TvSeries> topRatedTvList;

  TopRatedTvSeriesHasData(this.topRatedTvList);

  @override
  List<Object> get props => [topRatedTvList];
}

class TopRatedTvSeriesError extends TopRatedTvSeriesState {
  final String message;

  TopRatedTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}
