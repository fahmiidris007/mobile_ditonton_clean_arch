import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvseries/domain/entities/tv_series.dart';
import 'package:tvseries/domain/entities/tv_series_detail.dart';
import 'package:tvseries/domain/entities/tv_series_genre.dart';
import 'package:tvseries/domain/usecases/get_watchlist_tv_series.dart';
import 'package:tvseries/domain/usecases/get_watchlist_status.dart';
import 'package:tvseries/domain/usecases/remove_wathlist.dart';
import 'package:tvseries/domain/usecases/save_watchlist.dart';
import 'package:tvseries/presentation/bloc/watchlist/tv_series_watchlist_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'tv_series_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTvSeries,
  GetWatchlistStatusTvSeries,
  SaveWatchlistTvSeries,
  RemoveWatchListTvSeries,
])
void main() {
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late MockGetWatchlistStatusTvSeries mockGetWatchlistStatusTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchListTvSeries mockRemoveWatchListTvSeries;
  late TvSeriesWatchlistBloc bloc;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockGetWatchlistStatusTvSeries = MockGetWatchlistStatusTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchListTvSeries = MockRemoveWatchListTvSeries();
    bloc = TvSeriesWatchlistBloc(
      getWatchlistTvSeries: mockGetWatchlistTvSeries,
      getWatchlistStatusTvSeries: mockGetWatchlistStatusTvSeries,
      saveWatchlistTvSeries: mockSaveWatchlistTvSeries,
      removeWatchListTvSeries: mockRemoveWatchListTvSeries,
    );
  });

  final tTvSeries = TvSeries(
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

  final tTvSeriesDetail = TvSeriesDetail(
    id: 1,
    adult: false,
    name: 'Name',
    overview: 'Overview',
    firstAirDate: DateTime.parse('2001-01-21'),
    posterPath: 'Poster Path',
    backdropPath: 'Backdrop Path',
    genres: [TvSeriesGenre(id: 1, name: 'name')],
    numberOfEpisodes: 10,
    numberOfSeasons: 1,
    voteAverage: 8.5,
    voteCount: 100,
    originalName: 'Original Name',
    originalLanguage: 'en',
    popularity: 9.0,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
    'emits [TvSeriesWatchlistLoading, TvSeriesWatchlistLoaded] when FetchWatchlistTvSeries is added and succeeds',
    build: () => bloc,
    act: (bloc) {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      bloc.add(FetchWatchlistTvSeries());
    },
    expect: () => [
      TvSeriesWatchlistLoading(),
      TvSeriesWatchlistLoaded(tTvSeriesList),
    ],
  );

  blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
    'emits [TvSeriesWatchlistLoading, TvSeriesWatchlistError] when FetchWatchlistTvSeries is added and fails',
    build: () => bloc,
    act: (bloc) {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      bloc.add(FetchWatchlistTvSeries());
    },
    expect: () => [
      TvSeriesWatchlistLoading(),
      const TvSeriesWatchlistError('Server Failure'),
    ],
  );

  blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
    'emits [TvSeriesWatchlistLoading, StatusWatchlistTvSeries] when CheckWatchlistTvSeries is added',
    build: () => bloc,
    act: (bloc) {
      when(mockGetWatchlistStatusTvSeries.execute(1)).thenAnswer((_) async =>
          const Right<bool, bool>(true).fold((_) => true, (r) => r));
      bloc.add(const CheckWatchlistTvSeries(1));
    },
    expect: () => [
      TvSeriesWatchlistLoading(),
      const StatusWatchlistTvSeries(true),
    ],
  );

  blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
    'emits [TvSeriesWatchlistLoading, WatchlistTvSeriesMessage] when AddWatchlistTvSeries is added',
    build: () => bloc,
    act: (bloc) {
      when(mockSaveWatchlistTvSeries.execute(tTvSeriesDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      bloc.add(AddWatchlistTvSeries(tTvSeriesDetail));
    },
    expect: () => [
      TvSeriesWatchlistLoading(),
      const WatchlistTvSeriesMessage('Added to Watchlist'),
    ],
  );

  blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
    'emits [TvSeriesWatchlistLoading, WatchlistTvSeriesMessage] when RemoveWatchlistTvSeries is added',
    build: () => bloc,
    act: (bloc) {
      when(mockRemoveWatchListTvSeries.execute(tTvSeriesDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      bloc.add(RemoveWatchlistTvSeries(tTvSeriesDetail));
    },
    expect: () => [
      TvSeriesWatchlistLoading(),
      const WatchlistTvSeriesMessage('Removed from Watchlist'),
    ],
  );
}
