import 'package:core/domain/entities/tv_series.dart';
import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../repositories/tv_series_repository.dart';

class GetPopularTvSeries {
  final TvSeriesRepository repo;

  GetPopularTvSeries(this.repo);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repo.getPopularTvSeries();
  }
}
