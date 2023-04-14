import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../repositories/tv_series_repository.dart';

class GetTvSeriesDetail {
  final TvSeriesRepository repo;

  GetTvSeriesDetail(this.repo);

  Future<Either<Failure, TvSeriesDetail>> execute(int id) {
    return repo.getTvSeriesDetail(id);
  }
}
