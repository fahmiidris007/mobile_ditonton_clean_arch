part of 'tv_series_watchlist_bloc.dart';

sealed class TvSeriesWatchlistState extends Equatable {
  const TvSeriesWatchlistState();

  @override
  List<Object> get props => [];
}

final class TvSeriesWatchlistInitial extends TvSeriesWatchlistState {}

final class TvSeriesWatchlistLoading extends TvSeriesWatchlistState {}

final class TvSeriesWatchlistLoaded extends TvSeriesWatchlistState {
  final List<TvSeries> tvSeries;

  const TvSeriesWatchlistLoaded(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

final class TvSeriesWatchlistError extends TvSeriesWatchlistState {
  final String message;

  const TvSeriesWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

final class WatchlistTvSeriesMessage extends TvSeriesWatchlistState {
  final String message;

  const WatchlistTvSeriesMessage(this.message);

  @override
  List<Object> get props => [message];
}

final class StatusWatchlistTvSeries extends TvSeriesWatchlistState {
  final bool status;

  const StatusWatchlistTvSeries(this.status);

  @override
  List<Object> get props => [status];
}
