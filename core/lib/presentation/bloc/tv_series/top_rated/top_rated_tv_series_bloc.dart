import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;
  TopRatedTvSeriesBloc(this.getTopRatedTvSeries)
      : super(TopRatedTvSeriesInitial()) {
    on<TopRatedTvSeriesEvent>((event, emit) async {
      emit(TopRatedTvSeriesLoading());
      final result = await getTopRatedTvSeries.execute();
      result.fold((fail) => emit(TopRatedTvSeriesError(fail.message)),
          (data) => emit(TopRatedTvSeriesHasData(data)));
    });
  }
}
