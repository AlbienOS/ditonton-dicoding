import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/movie/get_movie_detail.dart';
import 'package:core/utils/failure.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(this._getMovieDetail) : super(MovieDetailEmpty()) {
    on<callMovieDetailById>((event, emit) async {
      final id = event.id;

      emit(MovieDetailLoading());
      final result = await _getMovieDetail.execute(id);
      result.fold((failure) {
        emit(MovieDetailError(failure.message));
      }, (data) {
        emit(MovieDetailHasData(data));
      });
    });
  }
}
