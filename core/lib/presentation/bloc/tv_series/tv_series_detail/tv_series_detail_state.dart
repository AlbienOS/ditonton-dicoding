part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState();

  @override
  List<Object> get props => [];
}

class TvSeriesDetailInitial extends TvSeriesDetailState {}

class TvSeriesDetailLoading extends TvSeriesDetailState {
  const TvSeriesDetailLoading();

  @override
  List<Object> get props => [];
}

class TvSeriesDetailHasData extends TvSeriesDetailState {
  final TvSeriesDetail tvSeriesDetail;

  TvSeriesDetailHasData(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class TvSeriesDetailError extends TvSeriesDetailState {
  final String message;

  TvSeriesDetailError(this.message);

  @override
  List<Object> get props => [message];
}
