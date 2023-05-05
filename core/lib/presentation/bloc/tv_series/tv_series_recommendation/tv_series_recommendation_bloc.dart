import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_recommendation.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_recommendation_event.dart';
part 'tv_series_recommendation_state.dart';

class TvSeriesRecommendationBloc
    extends Bloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState> {
  final GetTvSeriesRecommendation getTvSeriesRecommendation;
  TvSeriesRecommendationBloc(this.getTvSeriesRecommendation)
      : super(TvSeriesRecommendationInitial()) {
    on<CallTvSeriesRecommendationById>((event, emit) async {
      final tvId = event.tvId;

      emit(const TvSeriesRecommendationLoading());
      final result = await getTvSeriesRecommendation.execute(tvId);
      result.fold((fail) => emit(TvSeriesRecommendationError(fail.message)),
          (data) => emit(TvSeriesRecommendationHasData(data)));
    });
  }
}
