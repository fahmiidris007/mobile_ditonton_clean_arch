import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/now_playing/movie_now_play_bloc.dart';
import 'package:movies/presentation/bloc/popular/movie_popular_bloc.dart';
import 'package:movies/presentation/bloc/recommendation/movie_recommendation_bloc.dart';
import 'package:movies/presentation/bloc/search/movie_search_bloc.dart';
import 'package:movies/presentation/bloc/top_rated/movie_top_rated_bloc.dart';
import 'package:movies/presentation/bloc/watchlist/movie_watchlist_bloc.dart';
import 'package:movies/presentation/pages/about_page.dart';
import 'package:movies/presentation/pages/home_movie_page.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';
import 'package:movies/presentation/pages/now_playing_movies_page.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';
import 'package:movies/presentation/pages/search_page.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';
import 'package:movies/presentation/pages/watchlist_movies_page.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:tvseries/presentation/bloc/detail/tv_series_detail_bloc.dart';
import 'package:tvseries/presentation/bloc/now_playing/tv_series_now_playing_bloc.dart';
import 'package:tvseries/presentation/bloc/popular/tv_series_popular_bloc.dart';
import 'package:tvseries/presentation/bloc/recommendation/tv_series_recommendation_bloc.dart';
import 'package:tvseries/presentation/bloc/search/tv_series_search_bloc.dart';
import 'package:tvseries/presentation/bloc/top_rated/tv_series_top_rated_bloc.dart';
import 'package:tvseries/presentation/bloc/watchlist/tv_series_watchlist_bloc.dart';
import 'package:tvseries/presentation/pages/now_playing_tv_series_page.dart';
import 'package:tvseries/presentation/pages/popular_tv_series_page.dart';
import 'package:tvseries/presentation/pages/search_tv_series_page.dart';
import 'package:tvseries/presentation/pages/top_rated_tv_series.dart';
import 'package:tvseries/presentation/pages/tv_series_detail_page.dart';
import 'package:tvseries/presentation/pages/tv_series_list_page.dart';
import 'package:tvseries/presentation/pages/watchlist_tv_series_page.dart';

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
