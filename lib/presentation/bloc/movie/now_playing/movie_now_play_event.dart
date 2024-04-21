part of 'movie_now_play_bloc.dart';

abstract class MovieNowPlayEvent extends Equatable {
  const MovieNowPlayEvent();

  @override
  List<Object> get props => [];
}

final class FetchNowPlayingMovies extends MovieNowPlayEvent {}
