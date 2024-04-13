import 'package:ditonton/data/models/tvseries/tv_series_model.dart';
import 'package:ditonton/domain/entities/tvseries/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['country'],
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    originalLanguage: 'id',
    originalName: 'originalName',
    firstAirDate: DateTime.parse('2024-04-07'),
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['country'],
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    originalLanguage: 'id',
    originalName: 'originalName',
    firstAirDate: DateTime.parse('2024-04-07'),
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of TvSeries entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}