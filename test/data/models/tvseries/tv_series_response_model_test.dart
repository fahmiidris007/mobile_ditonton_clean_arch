import 'dart:convert';

import 'package:ditonton/data/models/tvseries/tv_series_model.dart';
import 'package:ditonton/data/models/tvseries/tv_series_reponse.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    adult: false,
    backdropPath: "/path.jpg",
    genreIds: [1],
    id: 1,
    originCountry: ['US'],
    overview: "overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    originalLanguage: "en",
    originalName: "original_name",
    name: "name",
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tTvSeriesResponseModel =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tvseries/now_playing.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "/path.jpg",
            "genre_ids": [1],
            "id": 1,
            "origin_country": ['US'],
            "overview": "overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "original_language": "en",
            "original_name": "original_name",
            "name": "name",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
