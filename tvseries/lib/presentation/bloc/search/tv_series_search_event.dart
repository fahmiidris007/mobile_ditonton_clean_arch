part of 'tv_series_search_bloc.dart';

sealed class TvSeriesSearchEvent extends Equatable {
  const TvSeriesSearchEvent();

  @override
  List<Object> get props => [];
}

final class FetchSearchTvSeries extends TvSeriesSearchEvent {
  final String query;

  const FetchSearchTvSeries(this.query);

  @override
  List<Object> get props => [query];
}
