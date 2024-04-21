import 'package:bloc/bloc.dart';
import '../../../domain/entities/tv_series.dart';
import '../../../domain/usecases/search_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_search_event.dart';
part 'tv_series_search_state.dart';

class TvSeriesSearchBloc
    extends Bloc<TvSeriesSearchEvent, TvSeriesSearchState> {
  TvSeriesSearchBloc({required this.searchTvSeries})
      : super(TvSeriesSearchInitial()) {
    on<FetchSearchTvSeries>(_onFetchSearchTvSeries);
  }

  final SearchTvSeries searchTvSeries;

  Future<void> _onFetchSearchTvSeries(
      FetchSearchTvSeries event, Emitter<TvSeriesSearchState> emit) async {
    emit(TvSeriesSearchLoading());
    final result = await searchTvSeries.execute(event.query);
    result.fold(
      (failure) => emit(TvSeriesSearchError(failure.message)),
      (tvSeries) {
        if (tvSeries.isEmpty) {
          emit(TvSeriesSearchNoData());
        } else {
          emit(TvSeriesSearchLoaded(tvSeries));
        }
      },
    );
  }
}
