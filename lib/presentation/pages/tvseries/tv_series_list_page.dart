import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tvseries/tv_series.dart';
import 'package:ditonton/presentation/bloc/tvseries/now_playing/tv_series_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/popular/tv_series_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/top_rated/tv_series_top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/tvseries/now_playing_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tvseries/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tvseries/search_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tvseries/top_rated_tv_series.dart';
import 'package:ditonton/presentation/pages/tvseries/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvSeriesListPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv_series_list';

  const TvSeriesListPage({Key? key}) : super(key: key);

  @override
  State<TvSeriesListPage> createState() => _TvSeriesListPageState();
}

class _TvSeriesListPageState extends State<TvSeriesListPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvSeriesNowPlayingBloc>().add(FetchNowPlayingTvSeries());
    context.read<TvSeriesPopularBloc>().add(FetchPopularTvSeries());
    context.read<TvSeriesTopRatedBloc>().add(FetchTopRatedTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvSeriesPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () => Navigator.pushNamed(
                    context, NowPlayingTvSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
                  builder: (context, state) {
                if (state is TvSeriesNowPlayingLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSeriesNowPlayingLoaded) {
                  return TvSeriesList(state.tvSeries);
                } else if (state is TvSeriesNowPlayingError) {
                  return Text(state.message);
                } else {
                  return Text('Something error');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                    context, PopularTvSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TvSeriesPopularBloc, TvSeriesPopularState>(
                  builder: (context, state) {
                if (state is TvSeriesPopularLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSeriesPopularLoaded) {
                  return TvSeriesList(state.tvSeries);
                } else if (state is TvSeriesPopularError) {
                  return Text(state.message);
                } else {
                  return Text('Something error');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTvSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
                  builder: (context, state) {
                if (state is TvSeriesTopRatedLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSeriesTopRatedLoaded) {
                  return TvSeriesList(state.tvSeries);
                } else if (state is TvSeriesTopRatedError) {
                  return Text(state.message);
                } else {
                  return Text('Something error');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeries;

  TvSeriesList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
