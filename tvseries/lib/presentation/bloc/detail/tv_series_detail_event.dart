part of 'tv_series_detail_bloc.dart';

sealed class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();

  @override
  List<Object> get props => [];
}

final class FetchDetailTvSeries extends TvSeriesDetailEvent {
  final int id;

  const FetchDetailTvSeries(this.id);

  @override
  List<Object> get props => [id];
}
