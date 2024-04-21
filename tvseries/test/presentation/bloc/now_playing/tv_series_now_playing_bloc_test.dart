import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvseries/domain/entities/tv_series.dart';
import 'package:tvseries/domain/usecases/get_now_playing_tv_series.dart';
import 'package:tvseries/presentation/bloc/now_playing/tv_series_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'tv_series_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late TvSeriesNowPlayingBloc bloc;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    bloc = TvSeriesNowPlayingBloc(
        getNowPlayingTvSeries: mockGetNowPlayingTvSeries);
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

  blocTest<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
    'emits [TvSeriesNowPlayingLoading, TvSeriesNowPlayingLoaded] when FetchNowPlayingTvSeries is added and succeeds',
    build: () => bloc,
    act: (bloc) {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      bloc.add(FetchNowPlayingTvSeries());
    },
    expect: () => [
      TvSeriesNowPlayingLoading(),
      TvSeriesNowPlayingLoaded(tTvSeriesList),
    ],
  );

  blocTest<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
    'emits [TvSeriesNowPlayingLoading, TvSeriesNowPlayingError] when FetchNowPlayingTvSeries is added and fails',
    build: () => bloc,
    act: (bloc) {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      bloc.add(FetchNowPlayingTvSeries());
    },
    expect: () => [
      TvSeriesNowPlayingLoading(),
      const TvSeriesNowPlayingError('Server Failure'),
    ],
  );
}
