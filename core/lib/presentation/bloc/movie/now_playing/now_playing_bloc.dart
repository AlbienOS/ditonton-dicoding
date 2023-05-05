import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  NowPlayingBloc(this.getNowPlayingMovies) : super(NowPlayingInitial()) {
    on<NowPlayingEvent>((event, emit) async {
      emit(const NowPlayingMovieLoading());
      final result = await getNowPlayingMovies.execute();
      result.fold((failure) => emit(NowPlayingMovieError(failure.message)),
          (data) => emit(NowPlayingMovieHasData(data)));
    });
  }
}
