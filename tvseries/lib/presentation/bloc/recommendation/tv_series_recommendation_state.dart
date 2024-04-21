part of 'tv_series_recommendation_bloc.dart';

sealed class TvSeriesRecommendationState extends Equatable {
  const TvSeriesRecommendationState();

  @override
  List<Object> get props => [];
}

final class TvSeriesRecommendationInitial extends TvSeriesRecommendationState {}

final class TvSeriesRecommendationLoading extends TvSeriesRecommendationState {}

final class TvSeriesRecommendationLoaded extends TvSeriesRecommendationState {
  final List<TvSeries> tvSeries;

  const TvSeriesRecommendationLoaded(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

final class TvSeriesRecommendationError extends TvSeriesRecommendationState {
  final String message;

  const TvSeriesRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}
