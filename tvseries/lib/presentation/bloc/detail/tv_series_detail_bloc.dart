import 'package:bloc/bloc.dart';
import '../../../domain/entities/tv_series_detail.dart';
import '../../../domain/usecases/get_tv_series_detail.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  TvSeriesDetailBloc({required this.getTvSeriesDetail})
      : super(TvSeriesDetailInitial()) {
    on<FetchDetailTvSeries>(_onFetchTvSeriesDetail);
  }

  final GetTvSeriesDetail getTvSeriesDetail;

  Future<void> _onFetchTvSeriesDetail(
      FetchDetailTvSeries event, Emitter<TvSeriesDetailState> emit) async {
    emit(TvSeriesDetailLoading());
    final result = await getTvSeriesDetail.execute(event.id);
    result.fold(
      (failure) => emit(TvSeriesDetailError(failure.message)),
      (tvSeries) => emit(TvSeriesDetailLoaded(tvSeries)),
    );
  }
}
