import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc({required this.getMovieDetail})
      : super(MovieDetailInitial()) {
    on<FetchMovieDetail>(_onFetchMovieDetail);
  }

  final GetMovieDetail getMovieDetail;

  Future<void> _onFetchMovieDetail(
      FetchMovieDetail event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoading());
    final result = await getMovieDetail.execute(event.id);
    result.fold(
      (failure) => emit(MovieDetailError(failure.message)),
      (movieDetail) => emit(MovieDetailLoaded(movieDetail)),
    );
  }
}
