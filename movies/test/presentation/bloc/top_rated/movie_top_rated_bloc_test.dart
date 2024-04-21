import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecase/get_top_rated_movies.dart';
import 'package:movies/presentation/bloc/top_rated/movie_top_rated_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'movie_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MovieTopRatedBloc bloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = MovieTopRatedBloc(getTopRatedMovies: mockGetTopRatedMovies);
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

  final tMovieList = <Movie>[tMovie];

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'emits [MovieTopRatedLoading, MovieTopRatedLoaded] when FetchTopRatedMovies is added and succeeds',
    build: () => bloc,
    act: (bloc) {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      bloc.add(FetchTopRatedMovies());
    },
    expect: () => [
      MovieTopRatedLoading(),
      MovieTopRatedLoaded(tMovieList),
    ],
  );

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'emits [MovieTopRatedLoading, MovieTopRatedError] when FetchTopRatedMovies is added and fails',
    build: () => bloc,
    act: (bloc) {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      bloc.add(FetchTopRatedMovies());
    },
    expect: () => [
      MovieTopRatedLoading(),
      const MovieTopRatedError('Server Failure'),
    ],
  );
}
