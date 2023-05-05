part of 'now_playing_bloc.dart';

abstract class NowPlayingEvent extends Equatable {
  const NowPlayingEvent();

  @override
  List<Object> get props => [];
}

class LoadNowPlayingEvent extends NowPlayingEvent {
  const LoadNowPlayingEvent();

  @override
  List<Object> get props => [];
}
