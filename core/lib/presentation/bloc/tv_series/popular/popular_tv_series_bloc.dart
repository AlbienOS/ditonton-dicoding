import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_series_event.dart';
part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTvSeries getPopularTvSeries;
  PopularTvSeriesBloc(this.getPopularTvSeries)
      : super(PopularTvSeriesInitial()) {
    on<PopularTvSeriesEvent>((event, emit) async {
      emit(PopularTvSeriesLoading());
      final result = await getPopularTvSeries.execute();
      result.fold((fail) => emit(PopularTvSeriesError(fail.message)),
          (data) => emit(PopularTvSeriesHasData(data)));
    });
  }
}
