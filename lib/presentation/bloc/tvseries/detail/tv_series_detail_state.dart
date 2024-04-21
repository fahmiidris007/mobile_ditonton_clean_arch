part of 'tv_series_detail_bloc.dart';

sealed class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState();

  @override
  List<Object> get props => [];
}

final class TvSeriesDetailInitial extends TvSeriesDetailState {}

final class TvSeriesDetailLoading extends TvSeriesDetailState {}

final class TvSeriesDetailLoaded extends TvSeriesDetailState {
  final TvSeriesDetail tvSeriesDetail;

  const TvSeriesDetailLoaded(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

final class TvSeriesDetailError extends TvSeriesDetailState {
  final String message;

  const TvSeriesDetailError(this.message);

  @override
  List<Object> get props => [message];
}
