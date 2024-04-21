import 'package:tvseries/data/models/tv_series_table.dart';
import 'package:tvseries/domain/entities/tv_series.dart';
import 'package:tvseries/domain/entities/tv_series_detail.dart';
import 'package:tvseries/domain/entities/tv_series_genre.dart';

final testTvSeries = TvSeries(
  adult: false,
  backdropPath: '/path.jpg',
  genreIds: const [1],
  id: 1,
  originCountry: const ['US'],
  originalLanguage: 'en',
  overview: 'overview',
  popularity: 1.0,
  posterPath: '/path.jpg',
  name: 'name',
  originalName: 'original_name',
  voteAverage: 1.0,
  voteCount: 1,
);

final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = TvSeriesDetail(
  adult: false,
  backdropPath: '/path.jpg',
  genres: [TvSeriesGenre(id: 1, name: 'Action')],
  id: 1,
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  overview: 'overview',
  posterPath: '/path.jpg',
  firstAirDate: DateTime.parse('2020-05-05'),
  name: 'name',
  originalName: 'original_name',
  originalLanguage: 'en',
  popularity: 1.0,
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: '/path.jpg',
  overview: 'overview',
);

const testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: '/path.jpg',
  overview: 'overview',
);

final testTvSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': '/path.jpg',
  'name': 'name',
};
