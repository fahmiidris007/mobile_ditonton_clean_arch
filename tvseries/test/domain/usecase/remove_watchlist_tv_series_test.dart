import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/usecases/remove_wathlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_tv_series_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchListTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = RemoveWatchListTvSeries(mockTvSeriesRepository);
  });

  test('should remove watchlist tv series from repository', () async {
    // arrange
    when(mockTvSeriesRepository.removeWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(mockTvSeriesRepository.removeWatchlist(testTvSeriesDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
