import 'package:tvseries/presentation/widgets/tv_series_card_list.dart';

import '../bloc/top_rated/tv_series_top_rated_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top_rated_tv_series';
  const TopRatedTvSeriesPage({super.key});

  @override
  State<TopRatedTvSeriesPage> createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvSeriesTopRatedBloc>().add(FetchTopRatedTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
            builder: (context, state) {
          if (state is TvSeriesTopRatedLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvSeriesTopRatedLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvSeries = state.tvSeries[index];
                return TvSeriesCard(tvSeries);
              },
              itemCount: state.tvSeries.length,
            );
          } else if (state is TvSeriesTopRatedError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Something error'));
          }
        }),
      ),
    );
  }
}
