import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import '../../domain/entities/tv_series.dart';
import '../../domain/entities/tv_series_detail.dart';
import '../../domain/entities/tv_series_genre.dart';
import '../bloc/detail/tv_series_detail_bloc.dart';
import '../bloc/recommendation/tv_series_recommendation_bloc.dart';
import '../bloc/watchlist/tv_series_watchlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv_series_detail';

  final int id;
  const TvSeriesDetailPage({super.key, required this.id});

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesDetailBloc>().add(FetchDetailTvSeries(widget.id));
      context
          .read<TvSeriesRecommendationBloc>()
          .add(FetchRecommendationTvSeries(widget.id));
      context
          .read<TvSeriesWatchlistBloc>()
          .add(CheckWatchlistTvSeries(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeriesDetailBloc, TvSeriesDetailState>(
        builder: (context, state) {
          final recommendations = context
              .select<TvSeriesRecommendationBloc, List<TvSeries>>((value) {
            var state = value.state;
            if (state is TvSeriesRecommendationLoaded) {
              return (state).tvSeries;
            }
            return [];
          });
          var isAddedToWatchlist =
              context.select<TvSeriesWatchlistBloc, bool>((value) {
            var state = value.state;
            if (state is StatusWatchlistTvSeries) {
              return state.status;
            }
            return false;
          });
          if (state is TvSeriesDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvSeriesDetailLoaded) {
            final movie = state.tvSeriesDetail;
            return SafeArea(
              child: DetailContent(
                movie,
                recommendations,
                isAddedToWatchlist,
              ),
            );
          } else if (state is TvSeriesDetailError) {
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
  final TvSeriesDetail tvSeries;
  final List<TvSeries> recommendations;
  final bool isAddedWatchlist;

  const DetailContent(
      this.tvSeries, this.recommendations, this.isAddedWatchlist,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
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
                              tvSeries.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<TvSeriesWatchlistBloc>()
                                      .add(AddWatchlistTvSeries(tvSeries));
                                } else {
                                  context
                                      .read<TvSeriesWatchlistBloc>()
                                      .add(RemoveWatchlistTvSeries(tvSeries));
                                }

                                debugPrint(
                                    'isAddedWatchlist: $isAddedWatchlist');

                                String message = '';

                                final state =
                                    BlocProvider.of<TvSeriesWatchlistBloc>(
                                            context)
                                        .state;
                                if (state is StatusWatchlistTvSeries) {
                                  message = isAddedWatchlist
                                      ? TvSeriesWatchlistBloc
                                          .watchlistRemoveSuccessMessage
                                      : TvSeriesWatchlistBloc
                                          .watchlistAddSuccessMessage;
                                } else {
                                  message = isAddedWatchlist == false
                                      ? TvSeriesWatchlistBloc
                                          .watchlistAddSuccessMessage
                                      : TvSeriesWatchlistBloc
                                          .watchlistRemoveSuccessMessage;
                                }

                                if (message ==
                                        TvSeriesWatchlistBloc
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        TvSeriesWatchlistBloc
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                  context
                                      .read<TvSeriesWatchlistBloc>()
                                      .add(CheckWatchlistTvSeries(tvSeries.id));
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
                              _showGenres(tvSeries.genres),
                            ),
                            Text(
                              '${tvSeries.numberOfSeasons} Seasons',
                            ),
                            Text(
                              '${tvSeries.numberOfEpisodes} Episodes',
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeries.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeries.overview,
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
                                          TvSeriesDetailPage.ROUTE_NAME,
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

  String _showGenres(List<TvSeriesGenre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
