import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';

class SaveWatchlistTvSeries {
  final TvSeriesRepository repo;

  SaveWatchlistTvSeries(this.repo);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeries) {
    return repo.saveWatchlist(tvSeries);
  }
}
