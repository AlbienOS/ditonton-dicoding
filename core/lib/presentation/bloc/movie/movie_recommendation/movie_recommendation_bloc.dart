import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations _movieRecommendations;

  MovieRecommendationBloc(this._movieRecommendations)
      : super(MovieRecommendationEmpty()) {
    on<callMovieRecommendationById>((event, emit) async {
      final id = event.id;

      emit(MovieRecommendationLoading());
      final result = await _movieRecommendations.execute(id);
      result.fold((failure) {
        emit(MovieRecommendationError(failure.message));
      }, (data) {
        emit(MovieRecommendationHasData(data));
      });
    });
  }
}
