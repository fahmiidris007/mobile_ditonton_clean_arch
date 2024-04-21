part of 'movie_popular_bloc.dart';

abstract class MoviePopularEvent extends Equatable {
  const MoviePopularEvent();

  @override
  List<Object> get props => [];
}

final class FetchPopularMovies extends MoviePopularEvent {}
