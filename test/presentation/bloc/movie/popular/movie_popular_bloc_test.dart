import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie/popular/movie_popular_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late MoviePopularBloc bloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    bloc = MoviePopularBloc(getPopularMovies: mockGetPopularMovies);
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

  blocTest<MoviePopularBloc, MoviePopularState>(
    'emits [MoviePopularLoading, MoviePopularLoaded] when FetchPopularMovies is added and succeeds',
    build: () => bloc,
    act: (bloc) {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      bloc.add(FetchPopularMovies());
    },
    expect: () => [
      MoviePopularLoading(),
      MoviePopularLoaded(tMovieList),
    ],
  );

  blocTest<MoviePopularBloc, MoviePopularState>(
    'emits [MoviePopularLoading, MoviePopularError] when FetchPopularMovies is added and fails',
    build: () => bloc,
    act: (bloc) {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      bloc.add(FetchPopularMovies());
    },
    expect: () => [
      MoviePopularLoading(),
      MoviePopularError('Server Failure'),
    ],
  );
}
