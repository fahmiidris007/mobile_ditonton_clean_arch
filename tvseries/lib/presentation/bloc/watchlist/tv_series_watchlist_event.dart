part of 'tv_series_watchlist_bloc.dart';

sealed class TvSeriesWatchlistEvent extends Equatable {
  const TvSeriesWatchlistEvent();

  @override
  List<Object> get props => [];
}

final class FetchWatchlistTvSeries extends TvSeriesWatchlistEvent {}

final class AddWatchlistTvSeries extends TvSeriesWatchlistEvent {
  final TvSeriesDetail tvSeriesDetail;

  const AddWatchlistTvSeries(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

final class RemoveWatchlistTvSeries extends TvSeriesWatchlistEvent {
  final TvSeriesDetail tvSeriesDetail;

  const RemoveWatchlistTvSeries(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

final class CheckWatchlistTvSeries extends TvSeriesWatchlistEvent {
  final int id;

  const CheckWatchlistTvSeries(this.id);

  @override
  List<Object> get props => [id];
}
