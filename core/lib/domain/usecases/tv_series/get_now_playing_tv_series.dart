import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../entities/tv_series.dart';

class GetNowPlayingTvSeries {
  final TvSeriesRepository repo;
  GetNowPlayingTvSeries(this.repo);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repo.getNowPlayingTvSeries();
  }
}
