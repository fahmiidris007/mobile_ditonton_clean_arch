part of 'movie_top_rated_bloc.dart';

abstract class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();

  @override
  List<Object> get props => [];
}

final class MovieTopRatedInitial extends MovieTopRatedState {}

final class MovieTopRatedLoading extends MovieTopRatedState {}

final class MovieTopRatedLoaded extends MovieTopRatedState {
  final List<Movie> movies;

  const MovieTopRatedLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

final class MovieTopRatedError extends MovieTopRatedState {
  final String message;

  const MovieTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}
