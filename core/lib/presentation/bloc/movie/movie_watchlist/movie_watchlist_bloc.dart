import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/movie/get_watchlist_status.dart';
import 'package:core/domain/usecases/movie/remove_watchlist.dart';
import 'package:core/domain/usecases/movie/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final SaveWatchlist insertWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchListStatus getWatchListStatus;
  MovieWatchlistBloc(
      {required this.insertWatchlist,
      required this.removeWatchlist,
      required this.getWatchListStatus})
      : super(MovieWatchlistInitial()) {
    on<LoadWatchlistStatus>((event, emit) async {
      final id = event.movieId;
      final result = await getWatchListStatus.execute(id);
      emit(MovieWatchlistStatus(result));
    });
    on<InsertWatchlist>((event, emit) async {
      final movieDetail = event.movieDetail;
      final result = await insertWatchlist.execute(movieDetail);
      result.fold((failure) {
        emit(MovieInsertWatchlistError(failure.message));
      }, (message) {
        emit(MovieInsertWatchlistSuccess(message));
      });
      add(LoadWatchlistStatus(event.movieDetail.id));
    });
    on<DoRemoveWatchlist>((event, emit) async {
      final movieDetail = event.movieDetail;
      final result = await removeWatchlist.execute(movieDetail);
      result.fold((failure) {
        emit(MovieRemoveWatchlistError(failure.message));
      }, (message) {
        emit(MovieRemoveWatchlistSuccess(message));
      });
      add(LoadWatchlistStatus(event.movieDetail.id));
    });
  }
}
