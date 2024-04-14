part of 'movie_now_play_bloc.dart';

sealed class MovieNowPlayState extends Equatable {
  const MovieNowPlayState();

  @override
  List<Object> get props => [];
}

final class MovieNowPlayInitial extends MovieNowPlayState {}

final class MovieNowPlayLoading extends MovieNowPlayState {}

final class MovieNowPlayLoaded extends MovieNowPlayState {
  final List<Movie> movies;

  const MovieNowPlayLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

final class MovieNowPlayError extends MovieNowPlayState {
  final String message;

  const MovieNowPlayError(this.message);

  @override
  List<Object> get props => [message];
}
