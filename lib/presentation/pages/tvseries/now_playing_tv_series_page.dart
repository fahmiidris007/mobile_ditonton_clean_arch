import 'package:ditonton/presentation/bloc/tvseries/now_playing/tv_series_now_playing_bloc.dart';
import 'package:ditonton/presentation/widgets/tvseries/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now_playing_tv_series';
  const NowPlayingTvSeriesPage({Key? key}) : super(key: key);

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
        title: Text('Now Playing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
            builder: (context, state) {
          if (state is TvSeriesNowPlayingLoading) {
            return Center(
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
            return Center(child: Text('Something error'));
          }
        }),
      ),
    );
  }
}
