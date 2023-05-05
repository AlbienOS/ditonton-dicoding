import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedBloc(this.getTopRatedMovies) : super(TopRatedInitial()) {
    on<TopRatedEvent>((event, emit) async {
      emit(TopRatedLoading());
      final result = await getTopRatedMovies.execute();
      result.fold((fail) => emit(TopRatedError('')),
          (data) => emit(TopRatedHasData(data)));
    });
  }
}
