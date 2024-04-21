part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

final class MovieSearchInitial extends MovieSearchState {}

final class MovieSearchLoading extends MovieSearchState {}

final class MovieSearchLoaded extends MovieSearchState {
  final List<Movie> searchResult;

  const MovieSearchLoaded(this.searchResult);

  @override
  List<Object> get props => [searchResult];
}

final class MovieSearchError extends MovieSearchState {
  final String message;

  const MovieSearchError(this.message);

  @override
  List<Object> get props => [message];
}
