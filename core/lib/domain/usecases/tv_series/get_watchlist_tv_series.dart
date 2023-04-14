import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';

class GetWatchlistTvSeries {
  final TvSeriesRepository repo;

  GetWatchlistTvSeries(this.repo);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repo.getWatchlistTvSeries();
  }
}
