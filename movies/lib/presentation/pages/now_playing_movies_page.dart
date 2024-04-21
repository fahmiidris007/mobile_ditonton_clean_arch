import 'package:movies/presentation/widgets/movie_card_list.dart';

import '../bloc/now_playing/movie_now_play_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now_playing-movie';

  const NowPlayingMoviesPage({super.key});

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<NowPlayingMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieNowPlayBloc>().add(FetchNowPlayingMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieNowPlayBloc, MovieNowPlayState>(
            builder: (context, state) {
          if (state is MovieNowPlayLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieNowPlayLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return MovieCard(movie);
              },
              itemCount: state.movies.length,
            );
          } else if (state is MovieNowPlayError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Something error'));
          }
        }),
      ),
    );
  }
}
