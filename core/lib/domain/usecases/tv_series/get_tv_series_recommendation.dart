import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../../entities/tv_series.dart';
import '../../repositories/tv_series_repository.dart';

class GetTvSeriesRecommendation {
  final TvSeriesRepository repo;

  GetTvSeriesRecommendation(this.repo);

  Future<Either<Failure, List<TvSeries>>> execute(int id) {
    return repo.getTvSeriesRecommendation(id);
  }
}
