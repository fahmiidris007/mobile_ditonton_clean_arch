import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv_series.dart';
import '../../../domain/entities/tv_series_detail.dart';
import '../../../domain/usecases/get_watchlist_status.dart';
import '../../../domain/usecases/get_watchlist_tv_series.dart';
import '../../../domain/usecases/remove_wathlist.dart';
import '../../../domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_watchlist_event.dart';
part 'tv_series_watchlist_state.dart';

class TvSeriesWatchlistBloc
    extends Bloc<TvSeriesWatchlistEvent, TvSeriesWatchlistState> {
  TvSeriesWatchlistBloc(
      {required this.getWatchlistTvSeries,
      required this.getWatchlistStatusTvSeries,
      required this.saveWatchlistTvSeries,
      required this.removeWatchListTvSeries})
      : super(TvSeriesWatchlistInitial()) {
    on<FetchWatchlistTvSeries>(_onFetchWatchlistTvSeries);
    on<CheckWatchlistTvSeries>(_onCheckWatchlistTvSeries);
    on<AddWatchlistTvSeries>(_onAddWatchlistTvSeries);
    on<RemoveWatchlistTvSeries>(_onRemoveWatchlistTvSeries);
  }

  final GetWatchlistTvSeries getWatchlistTvSeries;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchListTvSeries removeWatchListTvSeries;
  final GetWatchlistStatusTvSeries getWatchlistStatusTvSeries;
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  Future<void> _onFetchWatchlistTvSeries(FetchWatchlistTvSeries event,
      Emitter<TvSeriesWatchlistState> emit) async {
    emit(TvSeriesWatchlistLoading());
    final result = await getWatchlistTvSeries.execute();
    result.fold(
      (failure) => emit(TvSeriesWatchlistError(failure.message)),
      (tvSeries) => emit(TvSeriesWatchlistLoaded(tvSeries)),
    );
  }

  Future<void> _onCheckWatchlistTvSeries(CheckWatchlistTvSeries event,
      Emitter<TvSeriesWatchlistState> emit) async {
    emit(TvSeriesWatchlistLoading());
    final result = await getWatchlistStatusTvSeries.execute(event.id);
    emit(StatusWatchlistTvSeries(result));
  }

  Future<void> _onAddWatchlistTvSeries(
      AddWatchlistTvSeries event, Emitter<TvSeriesWatchlistState> emit) async {
    emit(TvSeriesWatchlistLoading());

    final result = await saveWatchlistTvSeries.execute(event.tvSeriesDetail);
    result.fold(
      (failure) => emit(TvSeriesWatchlistError(failure.message)),
      (message) => emit(WatchlistTvSeriesMessage(message)),
    );
  }

  Future<void> _onRemoveWatchlistTvSeries(RemoveWatchlistTvSeries event,
      Emitter<TvSeriesWatchlistState> emit) async {
    emit(TvSeriesWatchlistLoading());

    final result = await removeWatchListTvSeries.execute(event.tvSeriesDetail);
    result.fold(
      (failure) => emit(TvSeriesWatchlistError(failure.message)),
      (message) => emit(WatchlistTvSeriesMessage(message)),
    );
  }
}
