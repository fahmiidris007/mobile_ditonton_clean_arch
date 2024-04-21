import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/entities/movie/movie_genre.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/detail/movie_detail_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MovieDetailBloc bloc;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    bloc = MovieDetailBloc(getMovieDetail: mockGetMovieDetail);
  });

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

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [MovieDetailLoading, MovieDetailLoaded] when FetchMovieDetail is added and succeeds',
    build: () => bloc,
    act: (bloc) {
      when(mockGetMovieDetail.execute(any))
          .thenAnswer((_) async => Right(tMovieDetail));
      bloc.add(FetchMovieDetail(1));
    },
    expect: () => [
      MovieDetailLoading(),
      MovieDetailLoaded(tMovieDetail),
    ],
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [MovieDetailLoading, MovieDetailError] when FetchMovieDetail is added and fails',
    build: () => bloc,
    act: (bloc) {
      when(mockGetMovieDetail.execute(any))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      bloc.add(FetchMovieDetail(1));
    },
    expect: () => [
      MovieDetailLoading(),
      MovieDetailError('Server Failure'),
    ],
  );
}
