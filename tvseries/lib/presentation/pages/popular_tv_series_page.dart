import 'package:tvseries/presentation/widgets/tv_series_card_list.dart';

import '../bloc/popular/tv_series_popular_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular_tv_series';
  const PopularTvSeriesPage({super.key});

  @override
  State<PopularTvSeriesPage> createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvSeriesPopularBloc>().add(FetchPopularTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesPopularBloc, TvSeriesPopularState>(
            builder: (context, state) {
          if (state is TvSeriesPopularLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvSeriesPopularLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvSeries = state.tvSeries[index];
                return TvSeriesCard(tvSeries);
              },
              itemCount: state.tvSeries.length,
            );
          } else if (state is TvSeriesPopularError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Something error'));
          }
        }),
      ),
    );
  }
}
