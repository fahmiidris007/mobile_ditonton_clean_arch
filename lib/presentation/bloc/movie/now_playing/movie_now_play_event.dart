part of 'movie_now_play_bloc.dart';

sealed class MovieNowPlayEvent extends Equatable {
  const MovieNowPlayEvent();

  @override
  List<Object> get props => [];
}

final class FetchNowPlayingMovies extends MovieNowPlayEvent {}
