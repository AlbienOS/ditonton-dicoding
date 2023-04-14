import 'package:core/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/movie_detail.dart';

class SaveWatchlist {
  final MovieRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
