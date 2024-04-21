import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvseries/domain/entities/tv_series_detail.dart';
import 'package:tvseries/domain/entities/tv_series_genre.dart';
import 'package:tvseries/domain/usecases/get_tv_series_detail.dart';
import 'package:tvseries/presentation/bloc/detail/tv_series_detail_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late TvSeriesDetailBloc bloc;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    bloc = TvSeriesDetailBloc(getTvSeriesDetail: mockGetTvSeriesDetail);
  });

  final tTvSeriesDetail = TvSeriesDetail(
    id: 1,
    adult: false,
    name: 'Name',
    overview: 'Overview',
    firstAirDate: DateTime.parse('2001-01-21'),
    posterPath: 'Poster Path',
    backdropPath: 'Backdrop Path',
    genres: [TvSeriesGenre(id: 1, name: 'name')],
    numberOfEpisodes: 10,
    numberOfSeasons: 1,
    voteAverage: 8.5,
    voteCount: 100,
    originalName: 'Original Name',
    originalLanguage: 'en',
    popularity: 9.0,
  );

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'emits [TvSeriesDetailLoading, TvSeriesDetailLoaded] when FetchDetailTvSeries is added and succeeds',
    build: () => bloc,
    act: (bloc) {
      when(mockGetTvSeriesDetail.execute(any))
          .thenAnswer((_) async => Right(tTvSeriesDetail));
      bloc.add(const FetchDetailTvSeries(1));
    },
    expect: () => [
      TvSeriesDetailLoading(),
      TvSeriesDetailLoaded(tTvSeriesDetail),
    ],
  );

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'emits [TvSeriesDetailLoading, TvSeriesDetailError] when FetchDetailTvSeries is added and fails',
    build: () => bloc,
    act: (bloc) {
      when(mockGetTvSeriesDetail.execute(any))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      bloc.add(const FetchDetailTvSeries(1));
    },
    expect: () => [
      TvSeriesDetailLoading(),
      const TvSeriesDetailError('Server Failure'),
    ],
  );
}
