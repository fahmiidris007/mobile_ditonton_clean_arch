part of 'movie_recommendation_bloc.dart';

sealed class MovieRecommendationState extends Equatable {
  const MovieRecommendationState();

  @override
  List<Object> get props => [];
}

final class MovieRecommendationInitial extends MovieRecommendationState {}

final class MovieRecommendationLoading extends MovieRecommendationState {}

final class MovieRecommendationLoaded extends MovieRecommendationState {
  final List<Movie> movies;

  MovieRecommendationLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

final class MovieRecommendationError extends MovieRecommendationState {
  final String message;

  MovieRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}
