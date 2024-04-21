part of 'movie_recommendation_bloc.dart';

sealed class MovieRecommendationEvent extends Equatable {
  const MovieRecommendationEvent();

  @override
  List<Object> get props => [];
}

final class FetchMoviesRecommendation extends MovieRecommendationEvent {
  final int id;

  FetchMoviesRecommendation(this.id);

  @override
  List<Object> get props => [id];
}
