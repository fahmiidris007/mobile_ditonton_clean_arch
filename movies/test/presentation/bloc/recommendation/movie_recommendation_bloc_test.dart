import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecase/get_movie_recommendations.dart';
import 'package:movies/presentation/bloc/recommendation/movie_recommendation_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'movie_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MovieRecommendationBloc bloc;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    bloc = MovieRecommendationBloc(
        getMovieRecommendations: mockGetMovieRecommendations);
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

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'emits [MovieRecommendationLoading, MovieRecommendationLoaded] when FetchMoviesRecommendation is added and succeeds',
    build: () => bloc,
    act: (bloc) {
      when(mockGetMovieRecommendations.execute(any))
          .thenAnswer((_) async => Right(tMovieList));
      bloc.add(FetchMoviesRecommendation(1));
    },
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationLoaded(tMovieList),
    ],
  );

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'emits [MovieRecommendationLoading, MovieRecommendationError] when FetchMoviesRecommendation is added and fails',
    build: () => bloc,
    act: (bloc) {
      when(mockGetMovieRecommendations.execute(any))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      bloc.add(FetchMoviesRecommendation(1));
    },
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationError('Server Failure'),
    ],
  );
}
