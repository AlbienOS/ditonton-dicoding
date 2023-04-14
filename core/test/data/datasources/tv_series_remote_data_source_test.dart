import 'dart:convert';
import 'dart:io';

import 'package:core/data/datasources/tv_series_remote_data_source.dart';
import 'package:core/data/models/tv_series/tv_series_detail_model.dart';
import 'package:core/data/models/tv_series/tv_series_response.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing TvSeries', () {
    final ttvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/now_playing_tv_series.json')))
        .tvSeriesList;
    test('should return list of TvSeries model when response code is 200',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/now_playing_tv_series.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8'
                  }));
      //act
      final result = await dataSource.getNowPlayingTvSeries();
      //assert
      expect(result, equals(ttvSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSource.getNowPlayingTvSeries();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular TvSeries', () {
    final ttvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/popular_tv.json')))
        .tvSeriesList;
    test('should return Popular TvSeries list of TvSeries when respond is 200',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/popular_tv.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
              }));
      //act
      final result = await dataSource.getPopularTvSeries();
      //assert
      expect(result, equals(ttvSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSource.getPopularTvSeries();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tv Series', () {
    final ttvSerieslist = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_tv.json')))
        .tvSeriesList;
    test(
        'should return Top Rated list from Tv Series when response code is 200',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/top_rated_tv.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
              }));
      //act
      final result = await dataSource.getTopRatedTvSeries();
      //assert
      expect(result, equals(ttvSerieslist));
    });

    test('should throw a ServerException when the response code is 404',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/top_rated_tv.json'), 404));
      //act
      final call = dataSource.getTopRatedTvSeries();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get TvSeries Detail', () {
    final tvId = 1;
    final ttvSeriesDetail = TvSeriesDetailModel.fromJson(
        json.decode(readJson('dummy_data/tv_series_detail.json')));
    test(
        'should return TvSeries Detail from TvSeries when response code is 200',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tvId?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_series_detail.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
              }));
      //act
      final result = await dataSource.getTvSeriesDetail(tvId);
      //assert
      expect(result, equals(ttvSeriesDetail));
    });

    test('should throw ServerException when the response code is 404 or other',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tvId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSource.getTvSeriesDetail(tvId);
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get TvSeries Recommendations', () {
    final tvId = 1;
    final ttvSerieslist = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_recommendations.json')))
        .tvSeriesList;
    test('should retun list Tv Series Model when the response code is 200',
        () async {
      //arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tvId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_series_recommendations.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8'
                  }));
      //act
      final result = await dataSource.getTvSeriesRecommendation(tvId);
      //assert
      expect(result, equals(ttvSerieslist));
    });

    test('should throw ServerException when the response code is 404 or other',
        () async {
      //arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tvId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSource.getTvSeriesRecommendation(tvId);
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search TvSeries', () {
    final tQuery = 'Game of Thrones';
    final tvSearchResult = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/search_tv_series.json')))
        .tvSeriesList;
    test('should return list of search Tv Series when response code is 200',
        () async {
      //arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/search_tv_series.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
              }));
      //act
      final result = await dataSource.searchTvSeries(tQuery);
      //assert
      expect(result, tvSearchResult);
    });

    test('should throw ServerException when response code is 404 or other',
        () async {
      //assert
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSource.searchTvSeries(tQuery);
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
