import 'package:ditonton/presentation/bloc/movie/top_rated/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/widgets/movie/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieTopRatedBloc>().add(FetchTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
            builder: (context, state) {
          if (state is MovieTopRatedLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieTopRatedLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return MovieCard(movie);
              },
              itemCount: state.movies.length,
            );
          } else if (state is MovieTopRatedError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('Something error'));
          }
        }),
      ),
    );
  }
}
