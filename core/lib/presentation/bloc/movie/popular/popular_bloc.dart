import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/movie/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final GetPopularMovies getPopularMovies;
  PopularBloc(this.getPopularMovies) : super(PopularInitial()) {
    on<PopularEvent>((event, emit) async {
      emit(const PopularMovieLoading());
      final result = await getPopularMovies.execute();
      result.fold((fail) => emit(PopularMovieError(fail.message)),
          (data) => emit(PopularMovieHasData(data)));
    });
  }
}
