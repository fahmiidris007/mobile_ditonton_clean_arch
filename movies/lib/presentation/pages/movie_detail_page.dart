import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import '../../domain/entities/movie_genre.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../bloc/detail/movie_detail_bloc.dart';
import '../bloc/recommendation/movie_recommendation_bloc.dart';
import '../bloc/watchlist/movie_watchlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;
  const MovieDetailPage({super.key, required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieDetailBloc>().add(FetchMovieDetail(widget.id));
      context
          .read<MovieRecommendationBloc>()
          .add(FetchMoviesRecommendation(widget.id));
      context
          .read<MovieWatchlistBloc>()
          .add(CheckStatusWatchlistMovie(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          final recommendations =
              context.select<MovieRecommendationBloc, List<Movie>>((value) {
            var state = value.state;
            if (state is MovieRecommendationLoaded) {
              return (state).movies;
            }
            return [];
          });
          var isAddedToWatchlist =
              context.select<MovieWatchlistBloc, bool>((value) {
            var state = value.state;
            if (state is StatusWatchlist) {
              return state.status;
            }
            return false;
          });
          if (state is MovieDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailLoaded) {
            final movie = state.movieDetail;
            return SafeArea(
              child: DetailContent(
                movie,
                recommendations,
                isAddedToWatchlist,
              ),
            );
          } else if (state is MovieDetailError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('Something error'),
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isAddedWatchlist;

  const DetailContent(this.movie, this.recommendations, this.isAddedWatchlist,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<MovieWatchlistBloc>()
                                      .add(AddWatchlistMovie(movie));
                                } else {
                                  context
                                      .read<MovieWatchlistBloc>()
                                      .add(RemoveWatchlistMovie(movie));
                                }

                                debugPrint(
                                    'isAddedWatchlist: $isAddedWatchlist');

                                String message = '';

                                final state =
                                    BlocProvider.of<MovieWatchlistBloc>(context)
                                        .state;
                                if (state is StatusWatchlist) {
                                  message = isAddedWatchlist
                                      ? MovieWatchlistBloc
                                          .watchlistRemoveSuccessMessage
                                      : MovieWatchlistBloc
                                          .watchlistAddSuccessMessage;
                                } else {
                                  message = isAddedWatchlist == false
                                      ? MovieWatchlistBloc
                                          .watchlistAddSuccessMessage
                                      : MovieWatchlistBloc
                                          .watchlistRemoveSuccessMessage;
                                }

                                if (message ==
                                        MovieWatchlistBloc
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        MovieWatchlistBloc
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                  context
                                      .read<MovieWatchlistBloc>()
                                      .add(CheckStatusWatchlistMovie(movie.id));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final movie = recommendations[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          MovieDetailPage.ROUTE_NAME,
                                          arguments: movie.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: recommendations.length,
                              ),
                            ),
                            // } else {
                            //   return Container();
                            // }
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<MovieGenre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
