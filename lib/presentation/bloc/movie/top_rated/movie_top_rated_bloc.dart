import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  MovieTopRatedBloc({required this.getTopRatedMovies})
      : super(MovieTopRatedInitial()) {
    on<FetchTopRatedMovies>(_onFetchTopRatedMovies);
  }

  final GetTopRatedMovies getTopRatedMovies;

  Future<void> _onFetchTopRatedMovies(
      FetchTopRatedMovies event, Emitter<MovieTopRatedState> emit) async {
    emit(MovieTopRatedLoading());
    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) => emit(MovieTopRatedError(failure.message)),
      (movies) => emit(MovieTopRatedLoaded(movies)),
    );
  }
}
