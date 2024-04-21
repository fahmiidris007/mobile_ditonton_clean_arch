import 'package:ditonton/data/datasources/movie/db/database_movie_helper.dart';
import 'package:ditonton/data/datasources/movie/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tvseries/db/database_tv_series_helper.dart';
import 'package:ditonton/data/datasources/tvseries/tv_series_local_data_source.dart';
import 'package:ditonton/data/datasources/tvseries/tv_series_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/tvseries/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/tvseries/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/tvseries/get_top_rated_tv_series.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_series_recommendation.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tvseries/remove_wathlist.dart';
import 'package:ditonton/domain/usecases/tvseries/save_watchlist.dart';
import 'package:ditonton/domain/usecases/tvseries/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/movie/detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing/movie_now_play_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular/movie_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/recommendation/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/search/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/detail/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/now_playing/tv_series_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/popular/tv_series_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/recommendation/tv_series_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/search/tv_series_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/top_rated/tv_series_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/watchlist/tv_series_watchlist_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => MovieNowPlayBloc(
      getNowPlayingMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MoviePopularBloc(
      getPopularMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieTopRatedBloc(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchBloc(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieWatchlistBloc(
      getWatchlistMovies: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieRecommendationBloc(getMovieRecommendations: locator()),
  );
  locator.registerFactory(
    () => TvSeriesNowPlayingBloc(
      getNowPlayingTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesPopularBloc(
      getPopularTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesTopRatedBloc(
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesDetailBloc(
      getTvSeriesDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesSearchBloc(
      searchTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesWatchlistBloc(
      getWatchlistTvSeries: locator(),
      getWatchlistStatusTvSeries: locator(),
      saveWatchlistTvSeries: locator(),
      removeWatchListTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesRecommendationBloc(getTvSeriesRecommendations: locator()),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistStatusTvSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchListTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator
      .registerLazySingleton<DatabaseMovieHelper>(() => DatabaseMovieHelper());
  locator.registerLazySingleton<DatabaseTvSeriesHelper>(
      () => DatabaseTvSeriesHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
