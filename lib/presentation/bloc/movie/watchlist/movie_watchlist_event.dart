part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistMovies extends MovieWatchlistEvent {}

class AddWatchlistMovie extends MovieWatchlistEvent {
  final MovieDetail movie;

  AddWatchlistMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveWatchlistMovie extends MovieWatchlistEvent {
  final MovieDetail movie;

  RemoveWatchlistMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class CheckStatusWatchlistMovie extends MovieWatchlistEvent {
  final int id;

  CheckStatusWatchlistMovie(this.id);

  @override
  List<Object> get props => [id];
}
