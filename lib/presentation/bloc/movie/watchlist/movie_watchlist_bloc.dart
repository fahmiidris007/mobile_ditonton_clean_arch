import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  MovieWatchlistBloc(
      {required this.getWatchlistMovies,
      required this.getWatchListStatus,
      required this.saveWatchlist,
      required this.removeWatchlist})
      : super(MovieWatchlistInitial()) {
    on<FetchWatchlistMovies>(_onFetchWatchlistMovies);
    on<CheckStatusWatchlistMovie>(_onCheckStatusWatchlistMovie);
    on<AddWatchlistMovie>(_onAddWatchlistMovie);
    on<RemoveWatchlistMovie>(_onRemoveWatchlistMovie);
  }

  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  Future<void> _onFetchWatchlistMovies(
      FetchWatchlistMovies event, Emitter<MovieWatchlistState> emit) async {
    emit(MovieWatchlistLoading());
    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) => emit(MovieWatchlistError(failure.message)),
      (movies) => emit(MovieWatchlistLoaded(movies)),
    );
  }

  Future<void> _onCheckStatusWatchlistMovie(CheckStatusWatchlistMovie event,
      Emitter<MovieWatchlistState> emit) async {
    emit(MovieWatchlistLoading());
    final result = await getWatchListStatus.execute(event.id);
    emit(StatusWatchlist(result));
  }

  Future<void> _onAddWatchlistMovie(
      AddWatchlistMovie event, Emitter<MovieWatchlistState> emit) async {
    emit(MovieWatchlistLoading());
    final result = await saveWatchlist.execute(event.movie);
    result.fold(
      (failure) => emit(MovieWatchlistError(failure.message)),
      (message) => emit(WatchlistMessage(message)),
    );
  }

  Future<void> _onRemoveWatchlistMovie(
      RemoveWatchlistMovie event, Emitter<MovieWatchlistState> emit) async {
    emit(MovieWatchlistLoading());
    final result = await removeWatchlist.execute(event.movie);
    result.fold(
      (failure) => emit(MovieWatchlistError(failure.message)),
      (message) => emit(WatchlistMessage(message)),
    );
  }
}
