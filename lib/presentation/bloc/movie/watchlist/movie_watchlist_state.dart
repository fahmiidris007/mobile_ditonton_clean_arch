part of 'movie_watchlist_bloc.dart';

sealed class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();
  
  @override
  List<Object> get props => [];
}

final class MovieWatchlistInitial extends MovieWatchlistState {}
