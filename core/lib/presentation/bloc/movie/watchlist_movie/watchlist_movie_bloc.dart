import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;
  WatchlistMovieBloc(this.getWatchlistMovies) : super(WatchlistMovieInitial()) {
    on<WatchlistMovieEvent>((event, emit) async {
      emit(const WatchlistMovieLoading());
      final result = await getWatchlistMovies.execute();
      result.fold((fail) {
        emit(WatchlistMovieError(fail.message));
      }, (data) {
        emit(WatchlistMovieHasData(data));
      });
    });
  }
}
