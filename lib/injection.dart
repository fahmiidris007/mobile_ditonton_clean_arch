import 'package:core/utils/ssl_pinning.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/data/datasource/db/database_movie_helper.dart';
import 'package:movies/data/datasource/movie_local_data_source.dart';
import 'package:movies/data/datasource/movie_remote_data_source.dart';
import 'package:movies/data/repositories/movie_repository_impl.dart';
import 'package:movies/domain/repositories/movie_repository.dart';
import 'package:movies/domain/usecase/get_movie_detail.dart';
import 'package:movies/domain/usecase/get_movie_recommendations.dart';
import 'package:movies/domain/usecase/get_now_playing_movies.dart';
import 'package:movies/domain/usecase/get_popular_movies.dart';
import 'package:movies/domain/usecase/get_top_rated_movies.dart';
import 'package:movies/domain/usecase/get_watchlist_movies.dart';
import 'package:movies/domain/usecase/get_watchlist_status.dart';
import 'package:movies/domain/usecase/remove_watchlist.dart';
import 'package:movies/domain/usecase/save_watchlist.dart';
import 'package:movies/domain/usecase/search_movies.dart';
import 'package:movies/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/now_playing/movie_now_play_bloc.dart';
import 'package:movies/presentation/bloc/popular/movie_popular_bloc.dart';
import 'package:movies/presentation/bloc/recommendation/movie_recommendation_bloc.dart';
import 'package:movies/presentation/bloc/search/movie_search_bloc.dart';
import 'package:movies/presentation/bloc/top_rated/movie_top_rated_bloc.dart';
import 'package:movies/presentation/bloc/watchlist/movie_watchlist_bloc.dart';
import 'package:tvseries/data/datasource/db/database_tv_series_helper.dart';
import 'package:tvseries/data/datasource/tv_series_local_data_source.dart';
import 'package:tvseries/data/datasource/tv_series_remote_data_source.dart';
import 'package:tvseries/data/repositories/tv_series_repository_impl.dart';
import 'package:tvseries/domain/repositories/tv_series_repository.dart';
import 'package:tvseries/domain/usecases/get_now_playing_tv_series.dart';
import 'package:tvseries/domain/usecases/get_popular_tv_series.dart';
import 'package:tvseries/domain/usecases/get_top_rated_tv_series.dart';
import 'package:tvseries/domain/usecases/get_tv_series_detail.dart';
import 'package:tvseries/domain/usecases/get_tv_series_recommendation.dart';
import 'package:tvseries/domain/usecases/get_watchlist_status.dart';
import 'package:tvseries/domain/usecases/get_watchlist_tv_series.dart';
import 'package:tvseries/domain/usecases/remove_wathlist.dart';
import 'package:tvseries/domain/usecases/save_watchlist.dart';
import 'package:tvseries/domain/usecases/search_tv_series.dart';
import 'package:tvseries/presentation/bloc/detail/tv_series_detail_bloc.dart';
import 'package:tvseries/presentation/bloc/now_playing/tv_series_now_playing_bloc.dart';
import 'package:tvseries/presentation/bloc/popular/tv_series_popular_bloc.dart';
import 'package:tvseries/presentation/bloc/recommendation/tv_series_recommendation_bloc.dart';
import 'package:tvseries/presentation/bloc/search/tv_series_search_bloc.dart';
import 'package:tvseries/presentation/bloc/top_rated/tv_series_top_rated_bloc.dart';
import 'package:tvseries/presentation/bloc/watchlist/tv_series_watchlist_bloc.dart';

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
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
