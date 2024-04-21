import 'package:tvseries/presentation/widgets/tv_series_card_list.dart';

import '../bloc/now_playing/tv_series_now_playing_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now_playing_tv_series';
  const NowPlayingTvSeriesPage({super.key});

  @override
  State<NowPlayingTvSeriesPage> createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<NowPlayingTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvSeriesNowPlayingBloc>().add(FetchNowPlayingTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
            builder: (context, state) {
          if (state is TvSeriesNowPlayingLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvSeriesNowPlayingLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvSeries = state.tvSeries[index];
                return TvSeriesCard(tvSeries);
              },
              itemCount: state.tvSeries.length,
            );
          } else if (state is TvSeriesNowPlayingError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Something error'));
          }
        }),
      ),
    );
  }
}
