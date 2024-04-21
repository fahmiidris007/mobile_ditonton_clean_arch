part of 'tv_series_search_bloc.dart';

sealed class TvSeriesSearchState extends Equatable {
  const TvSeriesSearchState();

  @override
  List<Object> get props => [];
}

final class TvSeriesSearchInitial extends TvSeriesSearchState {}

final class TvSeriesSearchLoading extends TvSeriesSearchState {}

final class TvSeriesSearchLoaded extends TvSeriesSearchState {
  final List<TvSeries> searchResult;

  const TvSeriesSearchLoaded(this.searchResult);

  @override
  List<Object> get props => [searchResult];
}

final class TvSeriesSearchError extends TvSeriesSearchState {
  final String message;

  const TvSeriesSearchError(this.message);

  @override
  List<Object> get props => [message];
}

final class TvSeriesSearchNoData extends TvSeriesSearchState {}
