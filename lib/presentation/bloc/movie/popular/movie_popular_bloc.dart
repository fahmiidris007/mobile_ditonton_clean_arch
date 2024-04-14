import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  MoviePopularBloc({required this.getPopularMovies})
      : super(MoviePopularInitial()) {
    on<FetchPopularMovies>(_onFetchPopularMovies);
  }

  final GetPopularMovies getPopularMovies;

  Future<void> _onFetchPopularMovies(
      FetchPopularMovies event, Emitter<MoviePopularState> emit) async {
    emit(MoviePopularLoading());
    final result = await getPopularMovies.execute();
    result.fold(
      (failure) => emit(MoviePopularError(failure.message)),
      (movies) => emit(MoviePopularLoaded(movies)),
    );
  }
}
