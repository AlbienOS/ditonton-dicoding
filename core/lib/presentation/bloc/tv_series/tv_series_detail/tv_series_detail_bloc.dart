import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;
  TvSeriesDetailBloc(this.getTvSeriesDetail) : super(TvSeriesDetailInitial()) {
    on<CallTvSeriesDetailById>((event, emit) async {
      final id = event.id;

      emit(const TvSeriesDetailLoading());
      final result = await getTvSeriesDetail.execute(id);
      result.fold((fail) => emit(TvSeriesDetailError(fail.message)),
          (data) => emit(TvSeriesDetailHasData(data)));
    });
  }
}
