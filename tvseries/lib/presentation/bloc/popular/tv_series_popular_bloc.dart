import 'package:bloc/bloc.dart';
import '../../../domain/entities/tv_series.dart';
import '../../../domain/usecases/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_popular_event.dart';
part 'tv_series_popular_state.dart';

class TvSeriesPopularBloc
    extends Bloc<TvSeriesPopularEvent, TvSeriesPopularState> {
  TvSeriesPopularBloc({required this.getPopularTvSeries})
      : super(TvSeriesPopularInitial()) {
    on<FetchPopularTvSeries>(_onFetchPopularTvSeries);
  }

  final GetPopularTvSeries getPopularTvSeries;

  Future<void> _onFetchPopularTvSeries(
      FetchPopularTvSeries event, Emitter<TvSeriesPopularState> emit) async {
    emit(TvSeriesPopularLoading());
    final result = await getPopularTvSeries.execute();
    result.fold(
      (failure) => emit(TvSeriesPopularError(failure.message)),
      (tvSeries) => emit(TvSeriesPopularLoaded(tvSeries)),
    );
  }
}
