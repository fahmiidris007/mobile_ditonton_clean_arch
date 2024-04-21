import 'package:bloc/bloc.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecase/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_now_play_event.dart';
part 'movie_now_play_state.dart';

class MovieNowPlayBloc extends Bloc<MovieNowPlayEvent, MovieNowPlayState> {
  MovieNowPlayBloc({required this.getNowPlayingMovies})
      : super(MovieNowPlayInitial()) {
    on<FetchNowPlayingMovies>(_onFetchNowPlayingMovies);
  }

  final GetNowPlayingMovies getNowPlayingMovies;

  Future<void> _onFetchNowPlayingMovies(
      FetchNowPlayingMovies event, Emitter<MovieNowPlayState> emit) async {
    emit(MovieNowPlayLoading());
    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) => emit(MovieNowPlayError(failure.message)),
      (movies) => emit(MovieNowPlayLoaded(movies)),
    );
  }
}
