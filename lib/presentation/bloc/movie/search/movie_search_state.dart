part of 'movie_search_bloc.dart';

sealed class MovieSearchState extends Equatable {
  const MovieSearchState();
  
  @override
  List<Object> get props => [];
}

final class MovieSearchInitial extends MovieSearchState {}
