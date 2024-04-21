import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvseries/domain/entities/tv_series.dart';
import 'package:tvseries/domain/usecases/search_tv_series.dart';
import 'package:tvseries/presentation/bloc/search/tv_series_search_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'tv_series_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late MockSearchTvSeries mockSearchTvSeries;
  late TvSeriesSearchBloc bloc;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    bloc = TvSeriesSearchBloc(searchTvSeries: mockSearchTvSeries);
  });

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: '/path.jpg',
    genreIds: const [1],
    id: 1,
    originCountry: const ['US'],
    originalLanguage: 'en',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    name: 'name',
    originalName: 'original_name',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
    'emits [TvSeriesSearchLoading, TvSeriesSearchLoaded] when FetchSearchTvSeries is added and succeeds',
    build: () => bloc,
    act: (bloc) {
      when(mockSearchTvSeries.execute(any))
          .thenAnswer((_) async => Right(tTvSeriesList));
      bloc.add(const FetchSearchTvSeries('query'));
    },
    expect: () => [
      TvSeriesSearchLoading(),
      TvSeriesSearchLoaded(tTvSeriesList),
    ],
  );

  blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
    'emits [TvSeriesSearchLoading, TvSeriesSearchError] when FetchSearchTvSeries is added and fails',
    build: () => bloc,
    act: (bloc) {
      when(mockSearchTvSeries.execute(any))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      bloc.add(const FetchSearchTvSeries('query'));
    },
    expect: () => [
      TvSeriesSearchLoading(),
      const TvSeriesSearchError('Server Failure'),
    ],
  );
}
