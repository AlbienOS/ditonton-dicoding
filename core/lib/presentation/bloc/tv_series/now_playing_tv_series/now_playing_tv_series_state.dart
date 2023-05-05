part of 'now_playing_tv_series_bloc.dart';

abstract class NowPlayingTvSeriesState extends Equatable {
  const NowPlayingTvSeriesState();

  @override
  List<Object> get props => [];
}

class NowPlayingTvSeriesInitial extends NowPlayingTvSeriesState {}

class NowPlayingTvSeriesEmpty extends NowPlayingTvSeriesState {}

class NowPlayingTvSeriesLoading extends NowPlayingTvSeriesState {
  const NowPlayingTvSeriesLoading();

  @override
  List<Object> get props => [];
}

class NowPlayingTvSeriesHasData extends NowPlayingTvSeriesState {
  List<TvSeries> nowPlayingTvList;

  NowPlayingTvSeriesHasData(this.nowPlayingTvList);

  @override
  List<Object> get props => [nowPlayingTvList];
}

class NowPlayingTvSeriesError extends NowPlayingTvSeriesState {
  final String message;

  NowPlayingTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}
