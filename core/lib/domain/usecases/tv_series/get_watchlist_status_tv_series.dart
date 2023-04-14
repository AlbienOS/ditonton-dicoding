import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';

class GetWatchlistStatusTvSeries {
  final TvSeriesRepository repo;

  GetWatchlistStatusTvSeries(this.repo);

  Future<Either<Failure, bool>> execute(int tvId) {
    return repo.getWatchlistStatus(tvId);
  }
}
