import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/entities/movie/movie_genre.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/movie_watchlist_bloc.dart';

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
    genreIds: [1, 2, 3],
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
      MovieWatchlistError('Server Failure'),
    ],
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'emits [MovieWatchlistLoading, StatusWatchlist] when CheckStatusWatchlistMovie is added',
    build: () => bloc,
    act: (bloc) {
      when(mockGetWatchListStatus.execute(1)).thenAnswer(
          (_) async => Right<bool, bool>(true).fold((_) => true, (r) => r));
      bloc.add(CheckStatusWatchlistMovie(1));
    },
    expect: () => [
      MovieWatchlistLoading(),
      StatusWatchlist(true),
    ],
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'emits [MovieWatchlistLoading, WatchlistMessage] when AddWatchlistMovie is added',
    build: () => bloc,
    act: (bloc) {
      when(mockSaveWatchlist.execute(tMovieDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      bloc.add(AddWatchlistMovie(tMovieDetail));
    },
    expect: () => [
      MovieWatchlistLoading(),
      WatchlistMessage('Added to Watchlist'),
    ],
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'emits [MovieWatchlistLoading, WatchlistMessage] when RemoveWatchlistMovie is added',
    build: () => bloc,
    act: (bloc) {
      when(mockRemoveWatchlist.execute(tMovieDetail))
          .thenAnswer((_) async => Right('Removed from Watchlist'));
      bloc.add(RemoveWatchlistMovie(tMovieDetail));
    },
    expect: () => [
      MovieWatchlistLoading(),
      WatchlistMessage('Removed from Watchlist'),
    ],
  );
}
