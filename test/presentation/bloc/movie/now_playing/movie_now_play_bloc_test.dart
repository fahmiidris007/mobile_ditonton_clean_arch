import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing/movie_now_play_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'movie_now_play_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MovieNowPlayBloc bloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    bloc = MovieNowPlayBloc(getNowPlayingMovies: mockGetNowPlayingMovies);
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

  final tMovieList = <Movie>[tMovie];

  blocTest<MovieNowPlayBloc, MovieNowPlayState>(
    'emits [MovieNowPlayLoading, MovieNowPlayLoaded] when FetchNowPlayingMovies is added and succeeds',
    build: () => bloc,
    act: (bloc) {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      bloc.add(FetchNowPlayingMovies());
    },
    expect: () => [
      MovieNowPlayLoading(),
      MovieNowPlayLoaded(tMovieList),
    ],
  );

  blocTest<MovieNowPlayBloc, MovieNowPlayState>(
    'emits [MovieNowPlayLoading, MovieNowPlayError] when FetchNowPlayingMovies is added and fails',
    build: () => bloc,
    act: (bloc) {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      bloc.add(FetchNowPlayingMovies());
    },
    expect: () => [
      MovieNowPlayLoading(),
      MovieNowPlayError('Server Failure'),
    ],
  );
}
