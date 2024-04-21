import 'package:bloc/bloc.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecase/search_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  MovieSearchBloc({required this.searchMovies}) : super(MovieSearchInitial()) {
    on<FetchSearchMovies>(_onFetchSearchMovies);
  }

  final SearchMovies searchMovies;

  Future<void> _onFetchSearchMovies(
      FetchSearchMovies event, Emitter<MovieSearchState> emit) async {
    emit(MovieSearchLoading());
    final result = await searchMovies.execute(event.query);
    result.fold(
      (failure) => emit(MovieSearchError(failure.message)),
      (movies) => emit(MovieSearchLoaded(movies)),
    );
  }
}
