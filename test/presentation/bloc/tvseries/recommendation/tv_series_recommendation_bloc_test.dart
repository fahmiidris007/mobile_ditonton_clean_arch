import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries/tv_series.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_series_recommendation.dart';
import 'package:ditonton/presentation/bloc/tvseries/recommendation/tv_series_recommendation_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'tv_series_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late TvSeriesRecommendationBloc bloc;

  setUp(() {
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    bloc = TvSeriesRecommendationBloc(
        getTvSeriesRecommendations: mockGetTvSeriesRecommendations);
  });

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['US'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
    'emits [TvSeriesRecommendationLoading, TvSeriesRecommendationLoaded] when FetchRecommendationTvSeries is added and succeeds',
    build: () => bloc,
    act: (bloc) {
      when(mockGetTvSeriesRecommendations.execute(any))
          .thenAnswer((_) async => Right(tTvSeriesList));
      bloc.add(FetchRecommendationTvSeries(1));
    },
    expect: () => [
      TvSeriesRecommendationLoading(),
      TvSeriesRecommendationLoaded(tTvSeriesList),
    ],
  );

  blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
    'emits [TvSeriesRecommendationLoading, TvSeriesRecommendationError] when FetchRecommendationTvSeries is added and fails',
    build: () => bloc,
    act: (bloc) {
      when(mockGetTvSeriesRecommendations.execute(any))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      bloc.add(FetchRecommendationTvSeries(1));
    },
    expect: () => [
      TvSeriesRecommendationLoading(),
      TvSeriesRecommendationError('Server Failure'),
    ],
  );
}
