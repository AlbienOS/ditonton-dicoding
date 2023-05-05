part of 'popular_tv_series_bloc.dart';

abstract class PopularTvSeriesState extends Equatable {
  const PopularTvSeriesState();

  @override
  List<Object> get props => [];
}

class PopularTvSeriesInitial extends PopularTvSeriesState {}

class PopularTvSeriesLoading extends PopularTvSeriesState {
  const PopularTvSeriesLoading();

  @override
  List<Object> get props => [];
}

class PopularTvSeriesHasData extends PopularTvSeriesState {
  final List<TvSeries> popularTvList;

  PopularTvSeriesHasData(this.popularTvList);

  @override
  List<Object> get props => [popularTvList];
}

class PopularTvSeriesError extends PopularTvSeriesState {
  final String message;

  PopularTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}
