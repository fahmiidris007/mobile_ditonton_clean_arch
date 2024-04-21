import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
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
import 'package:ditonton/presentation/pages/movie/about_page.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movie/now_playing_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/search_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/tvseries/now_playing_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tvseries/search_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tvseries/tv_series_list_page.dart';
import 'package:ditonton/presentation/pages/tvseries/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tvseries/top_rated_tv_series.dart';
import 'package:ditonton/presentation/pages/tvseries/tv_series_detail_page.dart';
import 'package:ditonton/presentation/pages/tvseries/watchlist_tv_series_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<MovieNowPlayBloc>(
          create: (context) => di.locator<MovieNowPlayBloc>(),
        ),
        BlocProvider<MoviePopularBloc>(
          create: (context) => di.locator<MoviePopularBloc>(),
        ),
        BlocProvider<MovieTopRatedBloc>(
          create: (context) => di.locator<MovieTopRatedBloc>(),
        ),
        BlocProvider<MovieDetailBloc>(
          create: (context) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider<MovieSearchBloc>(
          create: (context) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider<MovieWatchlistBloc>(
          create: (context) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider<MovieRecommendationBloc>(
          create: (context) => di.locator<MovieRecommendationBloc>(),
        ),
        BlocProvider<TvSeriesNowPlayingBloc>(
          create: (context) => di.locator<TvSeriesNowPlayingBloc>(),
        ),
        BlocProvider<TvSeriesDetailBloc>(
          create: (context) => di.locator<TvSeriesDetailBloc>(),
        ),
        BlocProvider<TvSeriesTopRatedBloc>(
          create: (context) => di.locator<TvSeriesTopRatedBloc>(),
        ),
        BlocProvider<TvSeriesPopularBloc>(
          create: (context) => di.locator<TvSeriesPopularBloc>(),
        ),
        BlocProvider<TvSeriesSearchBloc>(
          create: (context) => di.locator<TvSeriesSearchBloc>(),
        ),
        BlocProvider<TvSeriesWatchlistBloc>(
          create: (context) => di.locator<TvSeriesWatchlistBloc>(),
        ),
        BlocProvider<TvSeriesRecommendationBloc>(
          create: (context) => di.locator<TvSeriesRecommendationBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Movie and Tv Series Catalogue App',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case NowPlayingMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => NowPlayingMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case TvSeriesListPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TvSeriesListPage());
            case TvSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id),
                settings: settings,
              );
            case PopularTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PopularTvSeriesPage());
            case TopRatedTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TopRatedTvSeriesPage());
            case WatchlistTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvSeriesPage());
            case SearchTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SearchTvSeriesPage());
            case NowPlayingTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => NowPlayingTvSeriesPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
