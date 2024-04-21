import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvseries/domain/entities/tv_series.dart';
import 'package:tvseries/domain/usecases/get_top_rated_tv_series.dart';
import 'package:tvseries/presentation/bloc/top_rated/tv_series_top_rated_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'tv_series_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late TvSeriesTopRatedBloc bloc;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    bloc = TvSeriesTopRatedBloc(getTopRatedTvSeries: mockGetTopRatedTvSeries);
  });

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: const ['US'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
    'emits [TvSeriesTopRatedLoading, TvSeriesTopRatedLoaded] when FetchTopRatedTvSeries is added and succeeds',
    build: () => bloc,
    act: (bloc) {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      bloc.add(FetchTopRatedTvSeries());
    },
    expect: () => [
      TvSeriesTopRatedLoading(),
      TvSeriesTopRatedLoaded(tTvSeriesList),
    ],
  );

  blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
    'emits [TvSeriesTopRatedLoading, TvSeriesTopRatedError] when FetchTopRatedTvSeries is added and fails',
    build: () => bloc,
    act: (bloc) {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      bloc.add(FetchTopRatedTvSeries());
    },
    expect: () => [
      TvSeriesTopRatedLoading(),
      const TvSeriesTopRatedError('Server Failure'),
    ],
  );
}
