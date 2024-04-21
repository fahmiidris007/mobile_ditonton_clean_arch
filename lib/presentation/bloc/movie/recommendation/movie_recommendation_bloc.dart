import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  MovieRecommendationBloc({required this.getMovieRecommendations})
      : super(MovieRecommendationInitial()) {
    on<FetchMoviesRecommendation>(_onFetchRecommendationMovies);
  }

  final GetMovieRecommendations getMovieRecommendations;

  Future<void> _onFetchRecommendationMovies(FetchMoviesRecommendation event,
      Emitter<MovieRecommendationState> emit) async {
    emit(MovieRecommendationLoading());
    final result = await getMovieRecommendations.execute(event.id);
    result.fold(
      (failure) => emit(MovieRecommendationError(failure.message)),
      (movies) => emit(MovieRecommendationLoaded(movies)),
    );
  }
}
