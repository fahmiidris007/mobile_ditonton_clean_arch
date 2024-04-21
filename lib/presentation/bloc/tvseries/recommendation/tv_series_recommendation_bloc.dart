import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvseries/tv_series.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_series_recommendation.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_recommendation_event.dart';
part 'tv_series_recommendation_state.dart';

class TvSeriesRecommendationBloc
    extends Bloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState> {
  TvSeriesRecommendationBloc({required this.getTvSeriesRecommendations})
      : super(TvSeriesRecommendationInitial()) {
    on<FetchRecommendationTvSeries>(_onFetchRecommendationTvSeries);
  }

  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  Future<void> _onFetchRecommendationTvSeries(FetchRecommendationTvSeries event,
      Emitter<TvSeriesRecommendationState> emit) async {
    emit(TvSeriesRecommendationLoading());
    final result = await getTvSeriesRecommendations.execute(event.id);
    result.fold(
      (failure) => emit(TvSeriesRecommendationError(failure.message)),
      (tvSeries) => emit(TvSeriesRecommendationLoaded(tvSeries)),
    );
  }
}
