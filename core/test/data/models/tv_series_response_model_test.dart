import 'dart:convert';

import 'package:core/data/models/tv_series/tv_series_model.dart';
import 'package:core/data/models/tv_series/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tvSeriesModel = TvSeriesModel(
    id: 1,
    name: "Marvel's Daredevil",
    overview: "overview",
    posterPath: "b.jpg",
  );

  final tvSeriesResponse =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tvSeriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series_data.json'));
      //act
      final result = TvSeriesResponse.fromJson(jsonMap);
      //expect
      expect(result, tvSeriesResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      //arrange

      //act
      final result = tvSeriesResponse.toJson();
      //assert
      final expectedJsonMap = {
        "results": [
          {
            "id": 1,
            "name": "Marvel's Daredevil",
            "overview": "overview",
            "poster_path": "b.jpg",
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
