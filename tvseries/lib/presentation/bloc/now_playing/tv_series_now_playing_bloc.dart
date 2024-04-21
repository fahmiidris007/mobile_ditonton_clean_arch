import 'package:bloc/bloc.dart';
import '../../../domain/entities/tv_series.dart';
import '../../../domain/usecases/get_now_playing_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_now_playing_event.dart';
part 'tv_series_now_playing_state.dart';

class TvSeriesNowPlayingBloc
    extends Bloc<TvSeriesNowPlayingEvent, TvSeriesNowPlayingState> {
  TvSeriesNowPlayingBloc({required this.getNowPlayingTvSeries})
      : super(TvSeriesNowPlayingInitial()) {
    on<FetchNowPlayingTvSeries>(_onFetchNowPlayingTvSeries);
  }

  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  Future<void> _onFetchNowPlayingTvSeries(FetchNowPlayingTvSeries event,
      Emitter<TvSeriesNowPlayingState> emit) async {
    emit(TvSeriesNowPlayingLoading());
    final result = await getNowPlayingTvSeries.execute();
    result.fold(
      (failure) => emit(TvSeriesNowPlayingError(failure.message)),
      (tvSeries) => emit(TvSeriesNowPlayingLoaded(tvSeries)),
    );
  }
}
