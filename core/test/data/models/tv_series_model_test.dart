import 'package:core/data/models/tv_series/tv_series_model.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tvSeriesModel = TvSeriesModel(
    id: 1,
    name: "Name",
    overview: "Overview",
    posterPath: "Poster",
  );

  final ttvSeries = TvSeries(
    id: 1,
    name: "Name",
    overview: "Overview",
    posterPath: "Poster",
  );

  test('should be a subclass of TvSeries entity', () async {
    final result = tvSeriesModel.toEntity();
    expect(result, ttvSeries);
  });
}
