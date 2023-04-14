import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/tv_series.dart';

class GetTopRatedTvSeries {
  final TvSeriesRepository repo;

  GetTopRatedTvSeries(this.repo);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repo.getTopRatedTvSeries();
  }
}
