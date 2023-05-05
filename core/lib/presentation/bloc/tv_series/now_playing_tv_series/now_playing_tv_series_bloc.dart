import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_tv_series_event.dart';
part 'now_playing_tv_series_state.dart';

class NowPlayingTvSeriesBloc
    extends Bloc<NowPlayingTvSeriesEvent, NowPlayingTvSeriesState> {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  NowPlayingTvSeriesBloc(this.getNowPlayingTvSeries)
      : super(NowPlayingTvSeriesInitial()) {
    on<NowPlayingTvSeriesEvent>((event, emit) async {
      emit(const NowPlayingTvSeriesLoading());
      final result = await getNowPlayingTvSeries.execute();
      result.fold((fail) => emit(NowPlayingTvSeriesError(fail.message)),
          (data) => emit(NowPlayingTvSeriesHasData(data)));
    });
  }
}
