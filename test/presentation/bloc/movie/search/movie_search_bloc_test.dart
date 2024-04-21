import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie/search/movie_search_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'movie_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MockSearchMovies mockSearchMovies;
  late MovieSearchBloc bloc;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    bloc = MovieSearchBloc(searchMovies: mockSearchMovies);
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

  blocTest<MovieSearchBloc, MovieSearchState>(
    'emits [MovieSearchLoading, MovieSearchLoaded] when FetchSearchMovies is added and succeeds',
    build: () => bloc,
    act: (bloc) {
      when(mockSearchMovies.execute(any))
          .thenAnswer((_) async => Right(tMovieList));
      bloc.add(FetchSearchMovies('query'));
    },
    expect: () => [
      MovieSearchLoading(),
      MovieSearchLoaded(tMovieList),
    ],
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'emits [MovieSearchLoading, MovieSearchError] when FetchSearchMovies is added and fails',
    build: () => bloc,
    act: (bloc) {
      when(mockSearchMovies.execute(any))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      bloc.add(FetchSearchMovies('query'));
    },
    expect: () => [
      MovieSearchLoading(),
      MovieSearchError('Server Failure'),
    ],
  );
}
