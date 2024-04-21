import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv_series.dart';
import '../../../domain/usecases/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_top_rated_event.dart';
part 'tv_series_top_rated_state.dart';

class TvSeriesTopRatedBloc
    extends Bloc<TvSeriesTopRatedEvent, TvSeriesTopRatedState> {
  TvSeriesTopRatedBloc({required this.getTopRatedTvSeries})
      : super(TvSeriesTopRatedInitial()) {
    on<FetchTopRatedTvSeries>(_onFetchTopRatedTvSeries);
  }

  final GetTopRatedTvSeries getTopRatedTvSeries;

  Future<void> _onFetchTopRatedTvSeries(
      FetchTopRatedTvSeries event, Emitter<TvSeriesTopRatedState> emit) async {
    emit(TvSeriesTopRatedLoading());
    final result = await getTopRatedTvSeries.execute();
    result.fold(
      (failure) => emit(TvSeriesTopRatedError(failure.message)),
      (tvSeries) => emit(TvSeriesTopRatedLoaded(tvSeries)),
    );
  }
}
