part of 'tv_series_popular_bloc.dart';

sealed class TvSeriesPopularState extends Equatable {
  const TvSeriesPopularState();

  @override
  List<Object> get props => [];
}

final class TvSeriesPopularInitial extends TvSeriesPopularState {}

final class TvSeriesPopularLoading extends TvSeriesPopularState {}

final class TvSeriesPopularError extends TvSeriesPopularState {
  final String message;

  TvSeriesPopularError(this.message);

  @override
  List<Object> get props => [message];
}

final class TvSeriesPopularLoaded extends TvSeriesPopularState {
  final List<TvSeries> tvSeries;

  TvSeriesPopularLoaded(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}
