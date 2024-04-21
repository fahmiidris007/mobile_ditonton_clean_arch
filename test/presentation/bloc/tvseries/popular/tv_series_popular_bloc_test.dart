import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries/tv_series.dart';
import 'package:ditonton/domain/usecases/tvseries/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/tvseries/popular/tv_series_popular_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'tv_series_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late TvSeriesPopularBloc bloc;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    bloc = TvSeriesPopularBloc(getPopularTvSeries: mockGetPopularTvSeries);
  });

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['US'],
    originalLanguage: 'en',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    name: 'name',
    originalName: 'original_name',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
    'emits [TvSeriesPopularLoading, TvSeriesPopularLoaded] when FetchPopularTvSeries is added and succeeds',
    build: () => bloc,
    act: (bloc) {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      bloc.add(FetchPopularTvSeries());
    },
    expect: () => [
      TvSeriesPopularLoading(),
      TvSeriesPopularLoaded(tTvSeriesList),
    ],
  );

  blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
    'emits [TvSeriesPopularLoading, TvSeriesPopularError] when FetchPopularTvSeries is added and fails',
    build: () => bloc,
    act: (bloc) {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      bloc.add(FetchPopularTvSeries());
    },
    expect: () => [
      TvSeriesPopularLoading(),
      TvSeriesPopularError('Server Failure'),
    ],
  );
}
