part of 'movie_top_rated_bloc.dart';

sealed class MovieTopRatedEvent extends Equatable {
  const MovieTopRatedEvent();

  @override
  List<Object> get props => [];
}

final class FetchTopRatedMovies extends MovieTopRatedEvent {}
