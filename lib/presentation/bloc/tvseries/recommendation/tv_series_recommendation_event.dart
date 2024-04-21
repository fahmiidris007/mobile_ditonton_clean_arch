part of 'tv_series_recommendation_bloc.dart';

sealed class TvSeriesRecommendationEvent extends Equatable {
  const TvSeriesRecommendationEvent();

  @override
  List<Object> get props => [];
}

final class FetchRecommendationTvSeries extends TvSeriesRecommendationEvent {
  final int id;

  const FetchRecommendationTvSeries(this.id);

  @override
  List<Object> get props => [id];
}
