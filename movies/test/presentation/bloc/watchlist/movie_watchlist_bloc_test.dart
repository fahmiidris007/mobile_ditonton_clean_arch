import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/entities/movie_genre.dart';
import 'package:movies/domain/usecase/get_watchlist_movies.dart';
import 'package:movies/domain/usecase/get_watchlist_status.dart';
import 'package:movies/domain/usecase/remove_watchlist.dart';
import 'package:movies/domain/usecase/save_watchlist.dart';
import 'package:movies/presentation/bloc/watchlist/movie_watchlist_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchlistMovies, GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MovieWatchlistBloc bloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    bloc = MovieWatchlistBloc(
        getWatchlistMovies: mockGetWatchlistMovies,
        getWatchListStatus: mockGetWatchListStatus,
        saveWatchlist: mockSaveWatchlist,
        removeWatchlist: mockRemoveWatchlist);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieDetail = MovieDetail(
    id: 1,
    title: 'Title',
    overview: 'Overview',
    releaseDate: 'Release Date',
    posterPath: 'Poster Path',
    backdropPath: 'Backdrop Path',
    genres: [MovieGenre(id: 1, name: 'name')],
    voteAverage: 8.5,
    voteCount: 100,
    adult: false,
    originalTitle: 'originalTitle',
    runtime: 100,
  );

  final tMovieList = <Movie>[tMovie];

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'emits [MovieWatchlistLoading, MovieWatchlistLoaded] when FetchWatchlistMovies is added and succeeds',
    build: () => bloc,
    act: (bloc) {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      bloc.add(FetchWatchlistMovies());
    },
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistLoaded(tMovieList),
    ],
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'emits [MovieWatchlistLoading, MovieWatchlistError] when FetchWatchlistMovies is added and fails',
    build: () => bloc,
    act: (bloc) {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      bloc.add(FetchWatchlistMovies());
    },
    expect: () => [
      MovieWatchlistLoading(),
      const MovieWatchlistError('Server Failure'),
    ],
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'emits [MovieWatchlistLoading, StatusWatchlist] when CheckStatusWatchlistMovie is added',
    build: () => bloc,
    act: (bloc) {
      when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async =>
          const Right<bool, bool>(true).fold((_) => true, (r) => r));
      bloc.add(CheckStatusWatchlistMovie(1));
    },
    expect: () => [
      MovieWatchlistLoading(),
      const StatusWatchlist(true),
    ],
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'emits [MovieWatchlistLoading, WatchlistMessage] when AddWatchlistMovie is added',
    build: () => bloc,
    act: (bloc) {
      when(mockSaveWatchlist.execute(tMovieDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      bloc.add(AddWatchlistMovie(tMovieDetail));
    },
    expect: () => [
      MovieWatchlistLoading(),
      const WatchlistMessage('Added to Watchlist'),
    ],
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'emits [MovieWatchlistLoading, WatchlistMessage] when RemoveWatchlistMovie is added',
    build: () => bloc,
    act: (bloc) {
      when(mockRemoveWatchlist.execute(tMovieDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      bloc.add(RemoveWatchlistMovie(tMovieDetail));
    },
    expect: () => [
      MovieWatchlistLoading(),
      const WatchlistMessage('Removed from Watchlist'),
    ],
  );
}
