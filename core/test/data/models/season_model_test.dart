import 'dart:convert';
import 'package:core/data/models/tv_series/season_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final seasonToJson = '''
{
    "id": 2,
    "poster_path": "/2b.jpg",
    "name": "Season 2",
    "overview": "overview",
    "season_number": 2
}
''';

  final seasonMap = jsonDecode(seasonToJson);
  test('should be able to convert to Entity class', () {
    final result = seasonModel.toEntity();
    expect(result, seasonToEntity);
  });

  test('should be able to convert Json', () {
    final model = SeasonModel.fromJson(seasonMap);
    expect(model, seasonModel);
  });

  test('should be equal to antoher model', () {
    final anotherSeasonModel = SeasonModel(
        id: 2,
        posterPath: '/2b.jpg',
        name: 'Season 2',
        overview: 'overview',
        seasonNumber: 2);
    expect(anotherSeasonModel, seasonModel);
  });
}
